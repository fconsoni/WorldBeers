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
    @Published private(set) var details: BeerDetails

    init(details: BeerDetails) {
        self.screenTitle.send(details.name)
        self.details = details
    }
}
