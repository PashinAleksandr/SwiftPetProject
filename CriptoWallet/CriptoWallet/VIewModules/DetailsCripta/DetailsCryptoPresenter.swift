//
//  DatailseCriptaPresenter.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 15.03.2022.
//

import Foundation

class DetailsCryptoPresenter: DetailsCryptoViewOutput {

    var cryptoCurrenciersService: CryptoCurrenciesServiceProtocol = CryptoCurrenciesService.shared
    var favoritService: FavouriteServiceProtocol = FavouritesService.shared

    weak var view: DetailsCryptoViewInput!
    
    init(view: DetailsCryptoViewInput) {
        self.view = view
    }
    
    func changeFavorits(coin: Coin) {
        do {
            let isContaines = favoritService.isContain(coin: coin)
            if isContaines {
                try favoritService.delete(coin: coin)
            } else {
                try favoritService.add(coin: coin)
            }
            view.updateState()
        } catch {
            view.show(error)
        }
    }
    
    func isFavorite(coin: Coin) -> Bool {
        return favoritService.isContain(coin: coin)
    }
    
    func add(coin: Coin) {
        do {
            try favoritService.add(coin: coin)
        } catch {
            view.show(error)
        }
    }
    
    func deleteCoin(coin: Coin) {
        do {
            try favoritService.delete(coin: coin)
        } catch {
            view.show(error)
        }
    }
}
