//
//  DetailViewController.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let data: Asset
    private var gradientLayer: CustomGradientLayer?
    
    private var detailView: DetailView {
        return view as! DetailView
    }
        
    override func loadView() {
        view = DetailView(frame: .zero, data: data)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backItem?.title = "\(data.name)"
        
        if gradientLayer == nil {
            gradientLayer = CustomGradientLayer(view: detailView)
            detailView.layer.addSublayer(gradientLayer!)
        }
    }

    init(data: Asset) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
