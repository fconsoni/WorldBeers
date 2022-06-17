//
//  DetailViewController.swift
//  WorldBeers
//
//  Created by Franco Consoni on 17/06/2022.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
    private let firstBrewedView: SimpleTextDetailView = {
        let firstBrewedView = SimpleTextDetailView()
        firstBrewedView.translatesAutoresizingMaskIntoConstraints = false
        return firstBrewedView
    }()

    private let brewerTipsView: SimpleTextDetailView = {
        let view = SimpleTextDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let foodPairingView: FoodPairingView = {
        let view = FoodPairingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var cancellables = Set<AnyCancellable>()
    private let viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        configureNavBar()
        setupView()
        setupActions()
    }

    private func configureNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = .black

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .lightGray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupView() {
        [firstBrewedView, brewerTipsView, foodPairingView].forEach(self.view.addSubview)

        NSLayoutConstraint.activate([
            firstBrewedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            firstBrewedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstBrewedView.widthAnchor.constraint(equalTo: view.widthAnchor),

            brewerTipsView.topAnchor.constraint(equalTo: firstBrewedView.bottomAnchor, constant: 36),
            brewerTipsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brewerTipsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),

            foodPairingView.topAnchor.constraint(equalTo: brewerTipsView.bottomAnchor, constant: 36),
            foodPairingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodPairingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            foodPairingView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -36)
        ])
    }

    private func setupActions() {
        viewModel.screenTitle.sink { [weak self] title in
            self?.navigationItem.title = title
        }.store(in: &cancellables)

        viewModel.$details.sink { [weak self] details in
            self?.firstBrewedView.show(.firstBrewed, of: details)
            self?.brewerTipsView.show(.brewerTips, of: details)
            self?.foodPairingView.show(details.foodPairing)
        }.store(in: &cancellables)
    }
}
