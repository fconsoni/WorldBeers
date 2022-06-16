//
//  Beer.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import UIKit

struct Beer: Codable {
    let name: String
    let imageUrl: String
    let description: String
    let abv: Double
    let ibu: Double?
}

extension Beer {
    private enum CodingKeys : String, CodingKey {
        case name,
             imageUrl = "image_url",
             description,
             abv,
             ibu
    }
}
