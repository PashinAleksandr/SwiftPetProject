//
//  WeakBox.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 08.04.2022.
//

import Foundation

protocol Observer: AnyObject {
    func update(coinArray: [Coin])
}

class WeakBox {
    weak var object: Observer?
    
    init(object: Observer) {
        self.object = object
    }
}
