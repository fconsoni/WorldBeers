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

    init(beers: [Beer]) {
        self.beers.send(beers)
    }

    func search(_ text: String) {
        print(text)
    }
}
