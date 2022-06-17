//
//  BrewerTipView.swift
//  WorldBeers
//
//  Created by Franco Consoni on 17/06/2022.
//

import UIKit

final class SimpleTextDetailView: UIView {
    enum Field {
        case firstBrewed
        case brewerTips
    }

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
        titleLabel.textColor = .black
        titleLabel.text = "First Brewed".uppercased()
        titleLabel.textAlignment = .center
        return titleLabel
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        [titleLabel, descriptionLabel].forEach(self.addSubview)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func show(_ field: Field, of details: BeerDetails) {
        switch field {
        case .firstBrewed:
            self.titleLabel.text = "First brewed".uppercased()
            self.descriptionLabel.text = details.firstBrewed
        case .brewerTips:
            self.titleLabel.text = "Brewer tips".uppercased()
            self.descriptionLabel.text = details.brewerTips
        }
    }
}
