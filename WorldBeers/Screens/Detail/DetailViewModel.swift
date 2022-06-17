//
//  DetailViewModel.swift
//  WorldBeers
//
//  Created by Franco Consoni on 17/06/2022.
//

import Foundation
import Combine

final class DetailViewModel {
    private(set) var screenTitle = CurrentValueSubject<String, Never>("")
    private let details: BeerDetails

    init(details: BeerDetails) {
        self.details = details

        self.screenTitle.send(details.name)
    }
}
