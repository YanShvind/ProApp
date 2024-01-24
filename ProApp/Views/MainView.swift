//
//  MainView.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

final class MainView: UIView {
    
    private let viewModel = MainViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending Coins"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"),
                        for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 12
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    private func setupUI() {
        addSubviews(titleLabel, searchButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            searchButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
