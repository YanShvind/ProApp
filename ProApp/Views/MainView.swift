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
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .clear
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 12
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.setLeftView(image: UIImage(systemName: "magnifyingglass")!)
        
        return textField
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 72
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.register(CryptoTableViewCell.self,
                           forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        viewModel.fetchCryptoData(page: 1) { result in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    self.viewModel.assetData = models
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        viewModel.delegate = self
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        
        searchButton.addTarget(self,
                               action: #selector(searchButtonPressed),
                               for: .touchUpInside)
        cancelButton.addTarget(self,
                               action: #selector(cancelButtonPressed),
                               for: .touchUpInside)
        
        setupUI()
    }
    
    @objc
    private func searchButtonPressed() {
        updateTopUI(isSearching: true)
    }
    
    @objc
    private func cancelButtonPressed() {
        updateTopUI(isSearching: false)
    }
    
    private func updateTopUI(isSearching: Bool) {
        titleLabel.isHidden = isSearching
        searchButton.isHidden = isSearching
        textField.isHidden = !isSearching
        cancelButton.isHidden = !isSearching
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    private func setupUI() {
        addSubviews(titleLabel, searchButton, tableView,
                    cancelButton, textField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            searchButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            textField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

extension MainView: MainViewModelDelegate {
    func updateUI(result: Result<AssetData, Error>) {
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.viewModel.assetData = models
                self.tableView.reloadData()
            }
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
