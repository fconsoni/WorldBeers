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
    private var allBeers: [Beer] = []

    init(beers: [Beer]) {
        self.allBeers = beers

        self.beers.send(beers)
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
