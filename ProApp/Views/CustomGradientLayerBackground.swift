//
//  CustomGradientLayerBackground.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 24.01.2024.
//

import UIKit

protocol CustomGradientLayerBackground: CALayer {
    var itemSize: CGFloat! { get }
    var view: UIView { get }
    
    init(view: UIView)
    
    func setupLayerBackground(view: UIView)
}
