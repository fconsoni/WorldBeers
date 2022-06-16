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
        imageView.image = Images.picturePlaceholder
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

    init() {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.imageView.image = Images.picturePlaceholder
        self.nameLabel.text = ""
        self.descriptionLabel.text = ""
        self.abvLabel.text = "%"
        self.ibuLabel.text = "%"
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }

    private func setupView() {
        let traitsStackView = UIStackView(arrangedSubviews: [abvLabel, ibuLabel])
        traitsStackView.translatesAutoresizingMaskIntoConstraints = false
        traitsStackView.axis = .horizontal
        traitsStackView.distribution = .equalSpacing
        traitsStackView.spacing = 8

        [imageView, nameLabel, descriptionLabel, traitsStackView].forEach(self.contentView.addSubview)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            traitsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            traitsStackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            nameLabel.topAnchor.constraint(equalTo: traitsStackView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }


    func show(_ beer: Beer) {
        self.beer = beer

        self.imageView.kf.setImage(with: URL(string: beer.imageUrl),
                                   placeholder: Images.picturePlaceholder,
                                   options: [.cacheOriginalImage])
        self.nameLabel.text = beer.name
        self.descriptionLabel.text = beer.description
        self.abvLabel.text = "ABV: \(beer.abv)%"
        self.ibuLabel.text = beer.ibu != nil ? "IBU: \(beer.ibu?.description ?? "")%" : "N/A"
    }
}
