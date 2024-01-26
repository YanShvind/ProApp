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

extension UILabel {
    convenience init(text: String, textColor: UIColor, font: UIFont){
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
