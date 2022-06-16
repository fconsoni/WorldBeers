//
//  SplashViewModel.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import Combine
import UIKit

final class SplashViewModel {
    private(set) var iconImage = CurrentValueSubject<UIImage, Never>(Images.splashIcon)
    private(set) var finishedLoadingBeers = PassthroughSubject<[Beer], Never>()
    private var cancellables = Set<AnyCancellable>()
    private var networkWorker: NetworkWorkable

    init(networkWorker: NetworkWorkable = NetworkWorker()) {
        self.networkWorker = networkWorker
    }

    func loadBeers() {
        self.networkWorker.make(Request(.get, endpoint: .beers(page: 1)))
            .receive(on: RunLoop.main)
            .decode(type: [Beer].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    print(error)
                }
            },receiveValue: { [weak self] beers in
                self?.finishedLoadingBeers.send(beers)
            }).store(in: &cancellables)
    }
}
