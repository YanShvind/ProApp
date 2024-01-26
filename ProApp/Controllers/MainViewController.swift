//
//  ViewController.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var mainView: MainView {
        return view as! MainView
    }
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layer = CustomGradientLayer(view: mainView)
        mainView.layer.addSublayer(layer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        mainView.delegate = self
    }
    
}

extension MainViewController: MainViewDelegate {
    func openDetalVC(data: Asset) {
        let detailVC = DetailViewController()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(detailVC, animated: false)
    }
}
