//
//  MainViewModel.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import Foundation
import UIKit

protocol MainViewModelDelegate: AnyObject {
    func updateUI(result: Result<AssetData, Error>)
}

final class MainViewModel: NSObject {
    
    weak var delegate: MainViewModelDelegate?
    
    var assetData: AssetData?
    var currentPage = 1
    let pageSize = 10
    
    func fetchCryptoData(page: Int, completion: @escaping (Result<AssetData, Error>) -> Void) {
        guard let url = URL(string: "https://api.coincap.io/v2/assets?limit=\(pageSize)&offset=\((page - 1) * pageSize)") else {
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 {
            currentPage += 1
            fetchCryptoData(page: currentPage) { result in
                DispatchQueue.main.async {
                    self.delegate?.updateUI(result: result)
                    scrollView.setContentOffset(.zero, animated: true)
                }
            }
        }
    }
}
