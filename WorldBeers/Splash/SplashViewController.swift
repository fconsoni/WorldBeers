//
//  SplashViewController.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import UIKit
import Combine

final class SplashViewController: UIViewController {
    private let iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewModel: SplashViewModel
    private var cancellables = Set<AnyCancellable>()


    init(viewModel: SplashViewModel = SplashViewModel()) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true

        setupView()

        viewModel.loadBeers()
    }


    private func setupView() {
        self.view.addSubview(iconView)

        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            iconView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.65),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor)
        ])

        self.viewModel.iconImage
            .sink { icon in
                self.iconView.image = icon
            }.store(in: &cancellables)
    }
}
