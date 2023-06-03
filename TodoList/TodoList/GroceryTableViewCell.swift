//
//  MyCustomTableViewCell.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 21.07.2021.
//

import UIKit

class GroceryTableViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func fill(with product: Product, index: Int) {
        numberLabel.text = (index + 1).description
        noteTextLabel.text = product.name
        countLabel.text = product.count.description
    }
}
