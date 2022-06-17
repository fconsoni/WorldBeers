//
//  SearchBarView.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import UIKit
import Combine

final class SearchBarView: UIView {
    private let searchTextBar: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clearButtonMode = .whileEditing
        textfield.textColor = .black
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = .white
        textfield.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("search.placeholder", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(0.8)])
        return textfield
    }()

    private(set) var textchanged = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        super.init(frame: .zero)

        self.backgroundColor = .lightGray

        setupView()
        setupACtions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        [searchTextBar].forEach(self.addSubview)

        NSLayoutConstraint.activate([
            searchTextBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            searchTextBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            searchTextBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            searchTextBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }

    private func setupACtions() {
        self.searchTextBar.textPublisher().sink { [weak self] text in
            self?.textchanged.send(text)
        }.store(in: &cancellables)
    }
}

private extension UITextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }
}
