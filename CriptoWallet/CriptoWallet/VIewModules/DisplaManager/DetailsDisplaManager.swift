//
//  DetailsDisplaManager.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 08.07.2022.
//

import UIKit
import Foundation

protocol DetailsDisplaManagerProtocol: AnyObject {
}

class DetailsDisplaManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var tableView: UITableView!
    weak var delegate: DetailsDisplaManagerProtocol?
    var viewModels: [CoinInformationCell.ViewModel] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fill(with coin: Coin) {
        viewModels.removeAll()
        
        let firstCell: CoinInformationCell.ViewModel = CoinInformationCell.ViewModel(name: "Капитализация", value:  coin.capitalization.description)
        viewModels.append(firstCell)
        
        let isPositive = coin.changeForDay > 0
        let dayChangesColor: UIColor = isPositive ? .green : .red
        let secondCell = CoinInformationCell.ViewModel(name: "Изменение за 24 часа ", value: coin.changeForDay.rounding(digits: 2).description, color: dayChangesColor)
        let thirdCell: CoinInformationCell.ViewModel = CoinInformationCell.ViewModel(name: "Предложение", value: coin.price.rounding(digits: 2).description)
        let fourthCell: CoinInformationCell.ViewModel = CoinInformationCell.ViewModel(name: "Объем за 24 часа", value: coin.proposal.description)
        let fifthCell: CoinInformationCell.ViewModel = CoinInformationCell.ViewModel(name: "Алгоритм подтверждения", value: coin.confirmationAlgorithm)
        let sixthCell: CoinInformationCell.ViewModel = CoinInformationCell.ViewModel(name: "Алгоритм хеширования", value: coin.hasingAlgorithm)
        viewModels = [firstCell, secondCell, thirdCell, fourthCell, fifthCell, sixthCell]
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinInformationCall") as? CoinInformationCell else {
            return UITableViewCell()
        }
        cell.fill(viewModel: viewModels[indexPath.row])
        cell.isLast = viewModels.count - 1 == indexPath.row
        return cell
    }
    
}
