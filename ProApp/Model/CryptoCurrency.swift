//
//  Cryptocurrency.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 25.01.2024.
//

import Foundation

struct CryptoCurrency: Codable {
    let data: CryptoInfo
    let timestamp: Int
}

// MARK: - DataClass
struct CryptoInfo: Codable {
    let id, rank, symbol, name: String
    let supply, maxSupply, marketCapUsd, volumeUsd24Hr: String
    let priceUsd, changePercent24Hr, vwap24Hr: String
}
