//
//  ViewController.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var loginView: MainView {
        return view as! MainView
    }
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let layer = CustomGradientLayer(view: loginView)
        loginView.layer.addSublayer(layer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

