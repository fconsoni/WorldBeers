//
//  BeerListView.swift
//  WorldBeers
//
//  Created by Franco Consoni on 15/06/2022.
//

import Foundation
import UIKit
import Combine

final class BeerListView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(BeerRow.self)
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()

    private(set) var selectedBeer = PassthroughSubject<Beer, Never>()
    private var beers: [Beer] = []

    init() {
        super.init(frame: .zero)

        collectionView.delegate = self
        collectionView.dataSource = self

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func show(_ beers: [Beer]) {
        self.beers = beers

//        UIView.performWithoutAnimation {
            self.collectionView.reloadData()
//        }
    }

    func setTopInset(_ inset: CGFloat) {
        self.collectionView.contentInset = UIEdgeInsets(top: inset, left: 0, bottom: 16, right: 0)
        self.collectionView.setNeedsLayout()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(BeerRow.self, for: indexPath)

        cell?.show(beers[indexPath.row])

        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fixedWidth = collectionView.frame.width - 32

        return CGSize(width: fixedWidth, height: 110)
    }
}
