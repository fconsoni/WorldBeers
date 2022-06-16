//
//  BeerRow.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import UIKit
import Kingfisher

final class BeerRow: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let abvLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ibuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var beer: Beer?

    override func prepareForReuse() {
        super.prepareForReuse()

        self.imageView.image = nil
        self.nameLabel.text = ""
        self.descriptionLabel.text = ""
        self.abvLabel.text = ""
        self.ibuLabel.text = ""
    }

    func show(_ beer: Beer) {
        self.beer = beer

        self.imageView.kf.setImage(with: URL(string: beer.imageUrl))
    }
}
