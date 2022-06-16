//
//  HomeViewController.swift
//  WorldBeers
//
//  Created by Franco Consoni on 15/06/2022.
//

import UIKit

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

    private func setupView() {
        [searchBarView, listView].forEach(self.view.addSubview)

        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.topAnchor),
            searchBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBarView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
