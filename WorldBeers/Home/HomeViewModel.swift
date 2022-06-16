//
//  HomeViewModel.swift
//  WorldBeers
//
//  Created by Franco Consoni on 15/06/2022.
//

import Foundation
import Combine

final class HomeViewModel {
    
    init(beers: [Beer]) {
        print(beers.map(\.name))
    }
}
