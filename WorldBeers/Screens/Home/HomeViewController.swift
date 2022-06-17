//
//  HomeViewController.swift
//  WorldBeers
//
//  Created by Franco Consoni on 15/06/2022.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    private let searchBarView: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let listView: BeerListView = {
        let view = BeerListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var cancellables = Set<AnyCancellable>()
    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        listView.setTopInset(searchBarView.frame.height)
    }

    private func setupView() {
        [listView, searchBarView].forEach(self.view.addSubview)

        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.topAnchor),
            searchBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBarView.widthAnchor.constraint(equalTo: view.widthAnchor),

            listView.topAnchor.constraint(equalTo: view.topAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        self.searchBarView.addDropShadow()
    }

    private func setupActions() {
        viewModel.beers.sink { [weak self] beers in
            self?.listView.show(beers)
        }.store(in: &cancellables)

        searchBarView.textchanged
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.viewModel.search(text)
            }.store(in: &cancellables)

        listView.selectedBeer.sink { [weak self] beer in
            self?.viewModel.pick(beer)
        }.store(in: &cancellables)
    }
}
