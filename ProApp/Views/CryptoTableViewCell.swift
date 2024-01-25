//
//  CryptoTableViewCell.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 24.01.2024.
//

import UIKit

final class CryptoTableViewCell: UITableViewCell {
    
    static let identifier = "CryptoTableViewCell"
    
    private let cryptoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 7
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 50 000.45"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 5.26%"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setupCryptoImageView()
    }
    
    func changeData(name: String, symbol: String, price: Double, change: Double) {
        self.nameLabel.text = name
        self.descriptionLabel.text = symbol

        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .decimal
        if let formattedPrice = priceFormatter.string(from: NSNumber(value: price)) {
            let modifiedPrice = formattedPrice.replacingOccurrences(of: ",", with: ".")
            self.priceLabel.text = "$ \(modifiedPrice)"
        }

        if change < 0 {
            self.changeLabel.text = "- \(abs(change)) %"
            self.changeLabel.textColor = .red
        } else if change > 0 {
            self.changeLabel.text = "+ \(change) %"
            self.changeLabel.textColor = .green
        } else {
            self.changeLabel.text = " \(change) %"
            self.changeLabel.textColor = .green
        }
    }

}

extension CryptoTableViewCell {
    private func setupCryptoImageView() {
        contentView.addSubviews(cryptoImageView, nameLabel, descriptionLabel, priceLabel, changeLabel)

        NSLayoutConstraint.activate([
            cryptoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cryptoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cryptoImageView.widthAnchor.constraint(equalToConstant: 48),
            cryptoImageView.heightAnchor.constraint(equalToConstant: 48),
            
            nameLabel.topAnchor.constraint(equalTo: cryptoImageView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: cryptoImageView.trailingAnchor, constant: 10),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                        
            priceLabel.topAnchor.constraint(equalTo: cryptoImageView.topAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3),
            changeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
