//
//  MainView.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func openDetalVC(data: Asset)
}

final class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    private let viewModel = MainViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending Coins".localized()
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
        button.setTitle("Cancel".localized(), for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .clear
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .clear
        searchBar.layer.borderWidth = 0.5
        searchBar.layer.cornerRadius = 12
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.textColor = .white
        searchBar.barTintColor = .clear
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.isHidden = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 72
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CryptoTableViewCell.self,
                           forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        fetchCoins()
        
        viewModel.delegate = self
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        searchBar.delegate = viewModel
        
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
        
        if viewModel.filteredData?.count == 1 {
            fetchCoins()
        }
    }
    
    private func updateTopUI(isSearching: Bool) {
        titleLabel.isHidden = isSearching
        searchButton.isHidden = isSearching
        searchBar.isHidden = !isSearching
        cancelButton.isHidden = !isSearching
    }
    
    private func fetchCoins() {
        viewModel.fetchCryptoData(page: 1) { result in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    self.viewModel.filteredData = models.data
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    private func setupUI() {
        addSubviews(titleLabel, searchButton, tableView,
                    cancelButton, searchBar)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            searchButton.topAnchor.constraint(equalTo: topAnchor, constant: 65),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 65),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

extension MainView: MainViewModelDelegate {
    func updateSearchUI(result: Result<Asset, Error>) {
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.viewModel.filteredData = [models]
                self.tableView.reloadData()
            }
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    
    func updateUI(result: Result<AssetData, Error>) {
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.viewModel.filteredData = models.data
                self.tableView.reloadData()
            }
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    
    func openDetailScreen(data: Asset) {
        delegate?.openDetalVC(data: data)
    }
}
