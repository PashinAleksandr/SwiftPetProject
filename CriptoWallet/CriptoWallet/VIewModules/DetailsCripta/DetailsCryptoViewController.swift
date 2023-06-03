//
//  DetailesCripta.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 14.03.2022.
//

import UIKit

class DetailsCryptoViewController: UIViewController, DetailsCryptoViewInput, DetailsDisplaManagerProtocol {
    @IBOutlet weak var favoritBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var coin: Coin! 
    var output: DetailsCryptoViewOutput!
    var coinViewModels: [CoinInformationCell] = []
    lazy var coinsDisplaManager: DetailsDisplaManager = DetailsDisplaManager(tableView: tableView)
    
    let filledStarName: String = "star.fill"
    let devastatedStarName: String = "star"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = DetailsCryptoPresenter(view: self)
        setupInitialState()
        updateState()
        reload(coin: coin)
    }
    
    @IBAction func changeFavoritsStatus(_ sender: UIBarButtonItem) {
        output.changeFavorits(coin: coin)
    }
    
    func reload(coin: Coin) {
        coinsDisplaManager.fill(with: coin)
    }
    
    func updateState() {
        let name = output.isFavorite(coin: coin) ? filledStarName : devastatedStarName
        let icon = UIImage(systemName: name)
        favoritBarButtonItem.image = icon
        tableView.isScrollEnabled = false
    }
    
    func setupInitialState() {
        let nib = UINib(nibName: "CoinInformationCall", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CoinInformationCall")
    }
    
    func coinDisplaManager(_ displayManager: DetailsDisplaManager, didSelect coin: Coin) {
        
    }
}

