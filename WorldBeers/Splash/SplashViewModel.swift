//
//  SplashViewModel.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import Combine
import UIKit

final class SplashViewModel {
    private(set) var iconImage = CurrentValueSubject<UIImage, Never>(Images.splashIcon)
    private(set) var finishedLoadingBeers = PassthroughSubject<[Beer], Never>()

    func loadBeers() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            self?.finishedLoadingBeers.send([])
        })
    }
}
