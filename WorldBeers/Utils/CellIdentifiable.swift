//
//  CollectionViewUtils.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import UIKit

protocol CellIdentifiable: AnyObject {
    static var identifier: String { get }
}

extension CellIdentifiable {
    static var identifier: String { String(describing: Self.self) }
}

//Mixin created to avoid boilerplate code
extension UICollectionView {
    func register<A: CellIdentifiable>(_ cellType: A.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }

    func dequeue<A: CellIdentifiable & UICollectionViewCell>(_ cellType: A.Type, for indexPath: IndexPath) -> A? {
        return self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? A
    }
}

