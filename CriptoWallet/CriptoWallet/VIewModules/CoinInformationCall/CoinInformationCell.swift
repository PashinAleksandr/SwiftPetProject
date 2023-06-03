//
//  DateCall.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 18.03.2022.
//

import UIKit

class CoinInformationCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var isLast: Bool = false {
        didSet {
            separatorInset.left = isLast ? frame.width : 90.0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorInset.left = isLast ? frame.width : 90.0
    }

    func fill(viewModel: CoinInformationCell.ViewModel) {
        nameLabel.text = viewModel.name
        valueLabel.text = viewModel.value
        valueLabel.textColor = viewModel.color
    }
    
    override func prepareForReuse() {
        isLast = false
    }
}

extension CoinInformationCell {
    struct ViewModel {
        var name: String
        var value: String
        var color: UIColor = UIColor.black
    }
}
