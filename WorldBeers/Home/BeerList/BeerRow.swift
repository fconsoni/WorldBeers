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
        imageView.kf.indicatorType = .activity
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

        self.imageView.kf.setImage(with: URL(string: beer.imageUrl),
                                   placeholder: Images.picturePlaceholder,
                                   options: [.cacheOriginalImage])
        self.nameLabel.text = beer.name
        self.descriptionLabel.text = beer.description
        self.abvLabel.text = "\(beer.abv)%"
        self.ibuLabel.text = beer.ibu != nil ? "\(beer.ibu?.description ?? "")%" : "N/A"
    }
}
