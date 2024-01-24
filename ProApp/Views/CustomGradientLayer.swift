//
//  CustomGradientLayer.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 24.01.2024.
//

import UIKit

final class CustomGradientLayer: CALayer, CustomGradientLayerBackground {

    var itemSize: CGFloat!
    var view: UIView
    
    private var firstGradient: CustomGradientLayerSpot!
    private var secondGradient: CustomGradientLayerSpot!
    private var thirdGradient: CustomGradientLayerSpot!
    
    init(view: UIView) {
        self.itemSize = view.frame.width
        self.view = view
        
        super.init()
        
        firstGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        secondGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        thirdGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        
        self.setupLayerBackground(view: view)
    }
    
    func setupLayerBackground(view: UIView) {
        self.addSublayer(firstGradient)
        self.addSublayer(secondGradient)
        self.addSublayer(thirdGradient)
        
        firstGradient.colors = [
            UIColor.blue.cgColor,
            UIColor.blue.cgColor,
            UIColor.black.cgColor
        ]
        
        secondGradient.colors = [
            UIColor.red.cgColor,
            UIColor.red.cgColor,
            UIColor.black.cgColor
        ]
        
        thirdGradient.colors = [
            UIColor.purple.cgColor,
            UIColor.purple.cgColor,
            UIColor.black.cgColor
        ]
        
        firstGradient.opacity = 0.15
        secondGradient.opacity = 0.05
        thirdGradient.opacity = 0.15
        
        firstGradient.frame = CGRect(x: view.frame.width - (itemSize / 1.5),
                                     y: view.frame.height * -0.15,
                                     width: itemSize,
                                     height: itemSize)
        
        secondGradient.frame = CGRect(x: itemSize / -1.8,
                                      y: view.frame.height / 2 - itemSize / 2 ,
                                      width: itemSize,
                                      height: itemSize)
        
        thirdGradient.frame = CGRect(x: view.frame.width - (itemSize / 1.5),
                                     y: view.frame.height * 0.6,
                                     width: itemSize,
                                     height: itemSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
