//
//  MainViewModel.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import Foundation
import UIKit

final class MainViewModel: NSObject {
    var assetData: AssetData?
    
    func fetchCryptoData(completion: @escaping (Result<AssetData, Error>) -> Void) {
        guard let url = URL(string: "https://api.coincap.io/v2/assets?limit=10") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let assetData = try JSONDecoder().decode(AssetData.self, from: data)
                completion(.success(assetData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

extension MainViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assetData?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CryptoTableViewCell.identifier,
            for: indexPath
        ) as? CryptoTableViewCell else {
            fatalError()
        }
        
        let asset = assetData?.data[indexPath.row]
        cell.changeData(name: asset?.name ?? "",
                        symbol: asset?.symbol ?? "",
                        price: asset?.priceUsd ?? 0.0,
                        change: asset?.changePercent24Hr ?? 0.0)
        
        cell.backgroundColor = .clear
        return cell
    }
}
