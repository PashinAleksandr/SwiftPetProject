//
//  FavoritListPresenter.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 15.03.2022.
//

import Foundation

class FavouriteListPresenter: NSObject, FavouriteListViewOutput {
        
    var coins: [Coin] {
        return favaritService.coins
    }
    
    var cryptoCurrenciesService: CryptoCurrenciesServiceProtocol = CryptoCurrenciesService.shared
    weak var view: FavouriteListViewInput!
    var favaritService: FavouriteServiceProtocol = FavouritesService.shared
    
    init(view: FavouriteListViewInput) {
        self.view = view
        super.init()
        favaritService.registration(observer: self)
    }
    
    deinit {
        favaritService.remove(observer: self)
    }
    
    func add(coin: Coin) {
        do {
            try favaritService.add(coin: coin)
        } catch {
            view.show(error)
        }
    }
    
    func delete(_ coin: Coin) {
        do {
            try favaritService.delete(coin: coin)
        } catch {
            view.show(error)
        }
    }
}

extension FavouriteListPresenter: Observer {
    func update(coinArray: [Coin]) {
        view.reload(coins: coins)
    }
}
