//
//  CryptoCurrenciesVIewIO.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 14.03.2022.
//

import Foundation

protocol CryptoCurrenciesViewInput: UIViewInput {
    func reload(coins: [Coin])
    func startLoading()
    func stopLoading()
    func setupInitialState()
}

protocol CryptoCurrenciesViewOutput {
    func viewIsReady()
}
