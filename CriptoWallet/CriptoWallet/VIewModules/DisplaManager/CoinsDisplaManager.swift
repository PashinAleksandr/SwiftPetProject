//
//  CoinsDisplaManager.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 13.05.2022.
//

import Foundation
import UIKit

protocol CoinsDisplaManagerDelegate: AnyObject {
    func coinDisplaManager(_ displayManager: CoinsDisplaManager, didSelect coin: Coin)
    func coinDisplaManager(_ displayManager: CoinsDisplaManager, didDelete coin: Coin)
    func coinDisplaManagerShouldDeleteCoin() -> Bool
}

class CoinsDisplaManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var tableView: UITableView!

    weak var delegate: CoinsDisplaManagerDelegate?
    
    var coins: [Coin] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.coinDisplaManager(self, didSelect: coins[indexPath.row])
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return coins.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell") as? CryptoCell else {
             return UITableViewCell()
         }
         cell.fill(coin: coins[indexPath.row])
         cell.isLast = coins.count - 1 == indexPath.row
         return cell
     }

     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
         guard let shouldDelete = delegate?.coinDisplaManagerShouldDeleteCoin() else {
             return .none
         }
         return shouldDelete ? .delete : .none
     }

     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             tableView.beginUpdates()
             let deletedCoin = coins.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .automatic)
             tableView.endUpdates()
             
             delegate?.coinDisplaManager(self, didDelete: deletedCoin)
         }
     }
    
}
