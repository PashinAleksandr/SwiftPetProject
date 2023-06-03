//
//  CellForControllers.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 17.03.2022.
//

import UIKit

class CryptoCell: UITableViewCell {
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var abbreviationCoinLabel: UILabel!
    @IBOutlet weak var fullTitleCoinLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var percentagePriceChangeLabel: UILabel!
    
    var isLast: Bool = false {
        didSet {
            separatorInset.left = isLast ? frame.width : 90.0
        }
    }
    
    var coin: Coin?

    override func layoutSubviews() {
        super.layoutSubviews()
        separatorInset.left = isLast ? frame.width : 90.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    private func changeCalor(label: UILabel, meaning: Double) {
        if meaning > 0 {
            label.textColor = UIColor.green
        } else {
            label.textColor = UIColor.red
        }
    }
    
    func fill(coin: Coin) {
        self.coin = coin
        abbreviationCoinLabel.text = coin.shortCoinName
        fullTitleCoinLabel.text = coin.fullCoinName
        coinPriceLabel.text = "$ " + coin.price.rounding(digits: 2).description
        changeCalor(label: percentagePriceChangeLabel, meaning: coin.changeForDay)
        percentagePriceChangeLabel.text = coin.changeForDay.rounding(digits: 2).description + "%"
        coinImageView.kf.setImage(with: coin.iconURL)
    }
    
    override func prepareForReuse() {
        isLast = false
        coin = nil
    }
}
