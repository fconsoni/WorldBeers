//
//  HomeViewController.swift
//  WorldBeers
//
//  Created by Franco Consoni on 15/06/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    private let searchTextBar: UITextField = {
        let view = UITextField()
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
    }

    private func setupView() {

    }
}
