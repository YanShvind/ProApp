//
//  MainViewModel.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 23.01.2024.
//

import Foundation
import UIKit

final class MainViewModel: NSObject {
    
}

extension MainViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CryptoTableViewCell.identifier,
            for: indexPath
        ) as? CryptoTableViewCell else {
            fatalError()
        }
        
        cell.textLabel?.text = "lll"
        
        return cell
    }
}
