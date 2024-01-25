//
//  CryptoData.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 25.01.2024.
//

import Foundation

struct AssetData: Codable {
    let data: [Asset]
}

struct Asset: Codable {
    let id: String
    let symbol: String
    let name: String
    let priceUsd: Double 
    let changePercent24Hr: Double

    private enum CodingKeys: String, CodingKey {
        case id, symbol, name, priceUsd, changePercent24Hr
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        symbol = try container.decode(String.self, forKey: .symbol)
        name = try container.decode(String.self, forKey: .name)
        
        if let priceString = try? container.decode(String.self, forKey: .priceUsd), let price = Double(priceString) {
            priceUsd = round(price * 100) / 100
        } else {
            priceUsd = 0.0
        }

        if let changeString = try? container.decode(String.self, forKey: .changePercent24Hr), let change = Double(changeString) {
            changePercent24Hr = round(change * 100) / 100
        } else {
            changePercent24Hr = 0.0
        }
    }
}
