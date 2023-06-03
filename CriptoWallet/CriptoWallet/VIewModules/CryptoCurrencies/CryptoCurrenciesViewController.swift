//
//  ViewController.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 14.03.2022.
//

import UIKit
import Kingfisher

class CryptoCurrenciesViewController: UIViewController, CryptoCurrenciesViewInput, CoinsDisplaManagerDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var coinsDisplaManager: CoinsDisplaManager = CoinsDisplaManager(tableView: tableView)
    var output: CryptoCurrenciesViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = CryptoCurrenciesPresenter(view: self)
        output.viewIsReady()
    }
    
    func setupInitialState() {
        coinsDisplaManager.delegate = self
        activityIndicator.hidesWhenStopped = true
        let nib = UINib(nibName: "CryptoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CryptoCell")
        tableView.rowHeight = 75
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailseCriptoVC = segue.destination as? DetailsCryptoViewController, let coin = sender as? Coin {
            detailseCriptoVC.coin = coin
        }
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func reload(coins: [Coin]) {
        coinsDisplaManager.coins = coins
    }
    
    func coinDisplaManager(_ displayManager: CoinsDisplaManager, didSelect coin: Coin) {
        performSegue(withIdentifier: "DetailsCryptoViewController", sender: coin)
    }
    
    func coinDisplaManager(_ displayManager: CoinsDisplaManager, didDelete coin: Coin) {
        
    }
    
    func coinDisplaManagerShouldDeleteCoin() -> Bool {
        false
    }
    
}
