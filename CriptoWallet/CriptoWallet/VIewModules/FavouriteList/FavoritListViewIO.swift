//
//  FavoritListViewIO.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 15.03.2022.
//

import Foundation

protocol FavouriteListViewInput: UIViewInput {
    func reload(coins: [Coin])
}

protocol FavouriteListViewOutput {
    func delete(_ coin: Coin)
}
