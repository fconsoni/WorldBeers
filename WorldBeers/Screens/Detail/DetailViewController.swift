//
//  DetailViewController.swift
//  WorldBeers
//
//  Created by Franco Consoni on 17/06/2022.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
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
//        [listView, searchBarView].forEach(self.view.addSubview)
//
//        NSLayoutConstraint.activate([
//            searchBarView.topAnchor.constraint(equalTo: view.topAnchor),
//            searchBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            searchBarView.widthAnchor.constraint(equalTo: view.widthAnchor),
//
//            listView.topAnchor.constraint(equalTo: view.topAnchor),
//            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            listView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
//        self.searchBarView.addDropShadow()
    }

    private func setupActions() {
        viewModel.screenTitle.sink { [weak self] title in
            self?.navigationItem.title = title
        }.store(in: &cancellables)
//        viewModel.beers.sink { [weak self] beers in
//            self?.listView.show(beers)
//        }.store(in: &cancellables)
//
//        searchBarView.textchanged
//            .debounce(for: 0.5, scheduler: RunLoop.main)
//            .sink { [weak self] text in
//                self?.viewModel.search(text)
//            }.store(in: &cancellables)
//
//        listView.selectedBeer.sink { [weak self] beer in
//            self?.viewModel.pick(beer)
//        }.store(in: &cancellables)
    }
}
