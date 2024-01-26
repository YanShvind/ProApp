//
//  DetailView.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import UIKit

final class DetailView: UIView {
    
    private let data: Asset
    
    private let priceLabel = UILabel(text: "$ 4 4332.55",
                                     textColor: .white,
                                     font: .systemFont(ofSize: 24))
    
    private let changePriceLabel = UILabel(text: "+ 100.48 (4.32%)",
                                           textColor: .green,
                                           font: .systemFont(ofSize: 14))
    
    private let horizontalStackview: UIStackView = {
        let horizontalStackview = UIStackView()
        horizontalStackview.distribution = .fillEqually
        horizontalStackview.axis = .horizontal
        horizontalStackview.spacing = 0
        horizontalStackview.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackview
    }()
    
    private let verticalFirstUIView: UIView = {
        let verticalFirstUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        verticalFirstUIView.backgroundColor = .clear
        verticalFirstUIView.layer.borderWidth = 2
        verticalFirstUIView.layer.borderColor = UIColor.clear.cgColor
        verticalFirstUIView.translatesAutoresizingMaskIntoConstraints = false
        return verticalFirstUIView
    }()
    
    private let verticalSecondUIView: UIView = {
        let verticalSecondUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        verticalSecondUIView.backgroundColor = .clear
        verticalSecondUIView.layer.borderWidth = 2
        verticalSecondUIView.layer.borderColor = UIColor.clear.cgColor
        verticalSecondUIView.translatesAutoresizingMaskIntoConstraints = false
        return verticalSecondUIView
    }()
    
    private let verticalThirdUIView: UIView = {
        let verticalThirdUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        verticalThirdUIView.backgroundColor = .clear
        verticalThirdUIView.layer.borderWidth = 2
        verticalThirdUIView.layer.borderColor = UIColor.clear.cgColor
        verticalThirdUIView.translatesAutoresizingMaskIntoConstraints = false
        return verticalThirdUIView
    }()
    
    private let verticalFirstStackView: UIStackView = {
        let verticalFirstStackView = UIStackView()
        verticalFirstStackView.axis = .vertical
        verticalFirstStackView.alignment = .center
        verticalFirstStackView.distribution = .fillEqually
        verticalFirstStackView.spacing = 5
        verticalFirstStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalFirstStackView
    }()
    
    private let verticalSecondStackView: UIStackView = {
        let verticalSecondStackView = UIStackView()
        verticalSecondStackView.axis = .vertical
        verticalSecondStackView.alignment = .center
        verticalSecondStackView.distribution = .fillEqually
        verticalSecondStackView.spacing = 5
        verticalSecondStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalSecondStackView
    }()
    
    private let verticalThirdStackView: UIStackView = {
        let verticalThirdStackView = UIStackView()
        verticalThirdStackView.axis = .vertical
        verticalThirdStackView.alignment = .center
        verticalThirdStackView.distribution = .fillEqually
        verticalThirdStackView.spacing = 5
        verticalThirdStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalThirdStackView
    }()
    
    private let lineImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "line")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let lineImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "line")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var changeCostPrice = 0.0
    private var changeCostPriceString = ""
    private let labelsTexts = ["Market Cap", "Supply", "Volume 24Hr"]
    private var counter = 0
    
    init(frame: CGRect, data: Asset) {
        self.data = data
        super.init(frame: frame)
        
        let infoData = [data.marketCapUsd.formattedMarketCap(),
                        data.supply.formattedMarketCapNoDollar(),
                        data.volumeUsd24Hr.formattedMarketCap()]

        priceLabel.text = "\(data.priceUsd)"
        
        let change = data.changePercent24Hr
        changeCostPrice = data.priceUsd * (change * 0.01)
        changeCostPriceString = String(format: "%.2f", changeCostPrice)
        costChange(change: change)

        [verticalFirstStackView, verticalSecondStackView, verticalThirdStackView].forEach { sv in
            let titleLabel = UILabel()
            let valueLabel = UILabel()
                        
            titleLabel.text = "\(labelsTexts[counter])"
            valueLabel.text = infoData[counter]
            
            titleLabel.font = .systemFont(ofSize: 12)
            valueLabel.font = .systemFont(ofSize: 16)
            
            titleLabel.textColor = .gray
            valueLabel.textColor = .white
            
            sv.addArrangedSubview(titleLabel)
            sv.addArrangedSubview(valueLabel)
            counter += 1
        }
        
        setupUI()
    }
    
    private func costChange(change: Double) {
        if change < 0 {
            self.changePriceLabel.text = "\(changeCostPriceString) (\(change)%)"
            self.changePriceLabel.textColor = .red
        } else if change > 0 {
            self.changePriceLabel.text = "+ \(changeCostPriceString) (\(change)%)"
            self.changePriceLabel.textColor = .green
        } else {
            self.changePriceLabel.text = "\(changeCostPriceString) (\(change)%)"
            self.changePriceLabel.textColor = .green
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailView {
    private func setupUI() {
        addSubviews(priceLabel, changePriceLabel, horizontalStackview)
        
        verticalFirstUIView.addSubviews(verticalFirstStackView, verticalSecondStackView, verticalThirdStackView)
        
        horizontalStackview.addArrangedSubview(verticalFirstUIView)
        horizontalStackview.addArrangedSubview(lineImage1)
        horizontalStackview.addArrangedSubview(verticalSecondUIView)
        horizontalStackview.addArrangedSubview(lineImage2)
        horizontalStackview.addArrangedSubview(verticalThirdUIView)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            changePriceLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 6),
            changePriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 7),
            
            verticalFirstStackView.topAnchor.constraint(equalTo: verticalFirstUIView.topAnchor),
            verticalFirstStackView.leadingAnchor.constraint(equalTo: verticalFirstUIView.leadingAnchor, constant: -10),
            verticalFirstStackView.trailingAnchor.constraint(equalTo: verticalFirstUIView.trailingAnchor),
            
            verticalSecondStackView.topAnchor.constraint(equalTo: verticalSecondUIView.topAnchor),
            verticalSecondStackView.leadingAnchor.constraint(equalTo: verticalSecondUIView.leadingAnchor, constant: -10),
            verticalSecondStackView.trailingAnchor.constraint(equalTo: verticalSecondUIView.trailingAnchor),
            
            verticalThirdStackView.topAnchor.constraint(equalTo: verticalThirdUIView.topAnchor),
            verticalThirdStackView.leadingAnchor.constraint(equalTo: verticalThirdUIView.leadingAnchor, constant: -10),
            verticalThirdStackView.trailingAnchor.constraint(equalTo: verticalThirdUIView.trailingAnchor),
            
            horizontalStackview.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            horizontalStackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            horizontalStackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}

