//
//  UIView+Extension.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import UIKit

extension UIView {
    func addDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowColor = UIColor.black.cgColor
    }

    func addCompleteRoundedShadow(cornerRadius: CGFloat = 16, shadowRadius: CGFloat = 8) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
