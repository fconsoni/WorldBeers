//
//  Beer.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import UIKit

struct Beer: Codable, Hashable {
    let name: String
    let imageUrl: String
    let description: String
    let abv: Double
    let ibu: Double?

    let firstBrewed: String
    let foodPairing: [String]
    let brewerTips: String

    var details: BeerDetails {
        BeerDetails(name: name,
                    firstBrewed: firstBrewed,
                    foodPairing: foodPairing,
                    brewerTips: brewerTips)
    }
}

extension Beer {
    private enum CodingKeys : String, CodingKey {
        case name,
             imageUrl = "image_url",
             description,
             abv,
             ibu,
             firstBrewed = "first_brewed",
             foodPairing = "food_pairing",
             brewerTips = "brewers_tips"
    }
}

struct BeerDetails {
    let name: String
    let firstBrewed: String
    let foodPairing: [String]
    let brewerTips: String
}
