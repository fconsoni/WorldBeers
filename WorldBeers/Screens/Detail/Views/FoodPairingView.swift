//
//  FoodPairingView.swift
//  WorldBeers
//
//  Created by Franco Consoni on 17/06/2022.
//

import UIKit

final class FoodPairingView: UIView {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
        titleLabel.textColor = .black
        titleLabel.text = NSLocalizedString("details.foodPairing", comment: "").uppercased()
        titleLabel.textAlignment = .center
        return titleLabel
    }()

    private let pairingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        [titleLabel, pairingsStackView].forEach(self.addSubview)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            pairingsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            pairingsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pairingsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pairingsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func singleRowLabel(from text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "\u{2022} \(text)"

        return label
    }

    func show(_ pairings: [String]) {
        pairings.map(singleRowLabel).forEach(pairingsStackView.addArrangedSubview)
    }
}
