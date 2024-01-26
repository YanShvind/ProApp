//
//  ViewController.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var gradientLayer: CustomGradientLayer?

    private var mainView: MainView {
        return view as! MainView
    }
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

        if gradientLayer == nil {
            gradientLayer = CustomGradientLayer(view: mainView)
            mainView.layer.addSublayer(gradientLayer!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
    }
}

extension MainViewController: MainViewDelegate {
    func openDetalVC(data: Asset) {
        let detailVC = DetailViewController(data: data)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(detailVC, animated: false)
    }
}
