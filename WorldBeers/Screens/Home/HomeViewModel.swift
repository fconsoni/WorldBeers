//
//  HomeViewModel.swift
//  WorldBeers
//
//  Created by Franco Consoni on 15/06/2022.
//

import Foundation
import Combine

final class HomeViewModel {
    private(set) var beerSelected = PassthroughSubject<Beer, Never>()
    private(set) var beers = CurrentValueSubject<[Beer], Never>([])
    private var cancellables = Set<AnyCancellable>()
    private var networkWorker: NetworkWorkable
    private var currentPage = 1
    private var allBeers: [Beer] = []

    init(beers: [Beer], networkWorker: NetworkWorkable = NetworkWorker()) {
        self.allBeers = beers
        self.networkWorker = networkWorker

        self.beers.send(beers)
    }

    func loadMoreBeers() {
        self.networkWorker.make(Request(.get, endpoint: .beers(page: currentPage + 1, perPage: 40)))
            .receive(on: RunLoop.main)
            .decode(type: [Beer].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    // Handle from here
                    print(error)
                }
            },receiveValue: { [weak self] beers in
                self?.currentPage += 1
                self?.allBeers.append(contentsOf: beers)
            }).store(in: &cancellables)
    }

    func search(_ text: String) {
        if text.isEmpty {
            beers.send(allBeers)
        } else {
            let filteredBeers = allBeers.filter{ $0.name.lowercased().contains(text.lowercased()) } + allBeers.filter{ $0.description.lowercased().contains(text.lowercased()) }

            beers.send(Array(Set(filteredBeers)))
        }
    }

    func pick(_ beer: Beer) {
        self.beerSelected.send(beer)
    }
}
