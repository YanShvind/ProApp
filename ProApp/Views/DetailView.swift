//
//  DetailView.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

final class DetailView: UIView {
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 3 232.55"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailView {
    private func setupUI() {
        addSubviews(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            
        ])
    }
}
