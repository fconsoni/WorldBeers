//
//  BeerRow.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import UIKit
import Kingfisher

final class BeerRow: UICollectionViewCell, CellIdentifiable {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFit
        imageView.image = Images.picturePlaceholder
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12, weight: .black)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()

    private let abvLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        label.textAlignment = .center
        return label
    }()

    private let ibuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        label.textAlignment = .center
        return label
    }()

    private var beer: Beer?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white

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

    override func layoutSubviews() {
        super.layoutSubviews()

        self.contentView.addCompleteRoundedShadow()
    }

    private func setupView() {
        let pictureContainer = pictureContainerView()
        let nameContainer = nameContainerView()

        [pictureContainer, nameContainer].forEach(self.contentView.addSubview)

        NSLayoutConstraint.activate([
            pictureContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pictureContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.41),

            nameContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameContainer.leadingAnchor.constraint(equalTo: pictureContainer.trailingAnchor),
            nameContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func pictureContainerView() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let traitsStackView = UIStackView(arrangedSubviews: [abvLabel, ibuLabel])
        traitsStackView.translatesAutoresizingMaskIntoConstraints = false
        traitsStackView.axis = .horizontal
        traitsStackView.distribution = .fillProportionally
        traitsStackView.spacing = 8

        [traitsStackView, imageView].forEach(container.addSubview)

        NSLayoutConstraint.activate([
            traitsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            traitsStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            traitsStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            traitsStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),

            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: traitsStackView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 64)
        ])

        return container
    }

    private func nameContainerView() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        [nameLabel, descriptionLabel].forEach(container.addSubview)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -12)
        ])

        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        return container
    }

    func show(_ beer: Beer) {
        self.beer = beer

        self.imageView.kf.setImage(with: URL(string: beer.imageUrl),
                                   placeholder: Images.picturePlaceholder,
                                   options: [.cacheOriginalImage])
        self.nameLabel.text = beer.name.uppercased()
        self.descriptionLabel.text = beer.description
        self.abvLabel.text = "ABV: \(beer.abv)%"
        self.ibuLabel.text = beer.ibu != nil ? "IBU: \(beer.ibu?.description ?? "")%" : "IBU: N/A"
    }
}
