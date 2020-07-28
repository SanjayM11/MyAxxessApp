//
//  UIView+RoundCorner.swift
//  MyAxxessApp
//
//  Created by Sanjay Mohnani on 28/07/20.
//  Copyright © 2020 Sanjay Mohnani. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.init(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 1).cgColor
        self.layer.maskedCorners = corners
    }
}
