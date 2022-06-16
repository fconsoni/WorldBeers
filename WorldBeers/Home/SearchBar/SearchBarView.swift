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
        textfield.textColor = .white
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = .lightGray
        textfield.attributedPlaceholder = NSAttributedString(string: "Search for name or description", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        return textfield
    }()

    private(set) var textchanged = PassthroughSubject<String?, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        super.init(frame: .zero)

        setupView()
        setupACtions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .black.withAlphaComponent(0.3)

        [searchTextBar, separator].forEach(self.addSubview)

        NSLayoutConstraint.activate([
            searchTextBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            searchTextBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            searchTextBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),

            separator.topAnchor.constraint(equalTo: searchTextBar.bottomAnchor, constant: 16),
            separator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separator.widthAnchor.constraint(equalTo: self.widthAnchor),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
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
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
}
