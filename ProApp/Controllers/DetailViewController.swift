//
//  DetailViewController.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var detailView: DetailView {
        return view as! DetailView
    }
    
    override func loadView() {
        view = DetailView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backItem?.title = "Custom"
        
        let layer = CustomGradientLayer(view: detailView)
        detailView.layer.addSublayer(layer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
