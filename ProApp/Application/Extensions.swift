//
//  Extensions.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 24.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
