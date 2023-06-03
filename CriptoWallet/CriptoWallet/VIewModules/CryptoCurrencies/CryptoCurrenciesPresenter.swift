//
//  CryptoCurrenciesPresenter.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 14.03.2022.
//

import Foundation

class CryptoCurrenciesPresenter: CryptoCurrenciesViewOutput {
    
    var cryptoCurrenciesService: CryptoCurrenciesServiceProtocol = CryptoCurrenciesService.shared
    weak var view: CryptoCurrenciesViewInput!

    
    init(view: CryptoCurrenciesViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        view.setupInitialState()
        load()
    }
    
    func load() {
        view.startLoading()
        cryptoCurrenciesService.fatchCryptoCurrencies { [weak view] coins, error in
            if let error = error {
                view?.showAlertRetry(title: "Erorr. Reason: \(error.localizedDescription)", massege: "Попробовать еще раз?") { [weak self] in
                    self?.load()
                }
            }
            if let coins = coins {
                view?.reload(coins: coins)
            }
            view?.stopLoading()
        }
    }
    
    
}
