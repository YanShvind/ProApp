//
//  ViewController.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
//    private var loginView: MainView {
//        return view as! MainView
//    }
//    
//    override func loadView() {
//        view = MainView()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        let layer = CustomGradientLayer(view: view)
        self.view.layer.addSublayer(layer)
    }

}

