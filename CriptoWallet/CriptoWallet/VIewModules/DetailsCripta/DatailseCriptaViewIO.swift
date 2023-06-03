//
//  DatailseCriptaViewIO.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 15.03.2022.
//

import Foundation
protocol DetailsCryptoViewInput: UIViewInput {
    func updateState()
}

protocol DetailsCryptoViewOutput {
    func isFavorite(coin: Coin) -> Bool
    func changeFavorits(coin: Coin)
}
