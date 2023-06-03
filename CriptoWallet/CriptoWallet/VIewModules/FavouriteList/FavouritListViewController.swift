//
//  FavoritListViewController.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 15.03.2022.
//

import Foundation
import UIKit

class FavouritListViewController: UIViewController, FavouriteListViewInput, CoinsDisplaManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex: Int = 0
    var output: FavouriteListViewOutput!
    lazy var coinsDisplaManager: CoinsDisplaManager = CoinsDisplaManager(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = FavouriteListPresenter(view: self)
        setupInitialStaite()
        coinsDisplaManager.delegate = self
    }
    
    func setupInitialStaite() {
        let nib = UINib(nibName: "CryptoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CryptoCell")
        tableView.rowHeight = 75
    }
    
    func reload(coins: [Coin]) {
        coinsDisplaManager.coins = coins
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailseCriptoVC = segue.destination as? DetailsCryptoViewController, let coin = sender as? Coin {
            detailseCriptoVC.coin = coin
        }
    }
    
    func coinDisplaManager(_ displayManager: CoinsDisplaManager, didSelect coin: Coin) {
        performSegue(withIdentifier: "DetailesCriptaViewController", sender: coin)
    }
    
    func coinDisplaManager(_ displayManager: CoinsDisplaManager, didDelete coin: Coin) {
        output.delete(coin)
    }
    
    func coinDisplaManagerShouldDeleteCoin() -> Bool {
        return true
    }
}

