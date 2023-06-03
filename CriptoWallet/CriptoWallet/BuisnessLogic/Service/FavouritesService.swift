//
//  FavoritService.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 08.04.2022.
//

import Foundation

protocol FavouriteServiceProtocol: Observable {
    var coins: [Coin] { get }
    func add(coin: Coin) throws
    func delete(coin: Coin) throws
    func isContain(coin: Coin) -> Bool
}

class FavouritesService: FavouriteServiceProtocol {
    static let shared = FavouritesService()
    
    var coins: [Coin] = [] {
        didSet {
            notifyObservers()
        }
    }
    
    private var observers: [WeakBox] = []
    
    private init() {
        do {
            coins = try getCoins()
        } catch {
            print(error)
        }
    }
    
    func add(coin: Coin) throws {
        guard !isContain(coin: coin) else {
            return
        }
        coins.append(coin)
        try update(coins: coins)
    }
    
    func isContain(coin: Coin) -> Bool {
        let contains = coins.contains { favoritesCoin in
            coin == favoritesCoin
        }
        return contains
    }
    
    func delete(coin: Coin) throws {
        let firstCoin = coins.enumerated().first(where: { $0.element == coin })
        guard let index = firstCoin?.offset else { return }
        coins.remove(at: index)
        try update(coins: coins)
    }
    
    func registration(observer: Observer) {
        let contains = observers.contains { weakBox in
            observer === weakBox.object
        }
        if !contains {
            let tmp: WeakBox = WeakBox(object: observer)
            observers.append(tmp)
            observer.update(coinArray: coins)
        }
    }
    
    func remove(observer: Observer) {
        observers.removeAll { weakBox in
            weakBox.object === observer
        }
    }
    
    func notifyObservers() {
        observers.forEach { $0.object?.update(coinArray: coins)}
    }
    
    private func update(coins: [Coin]) throws {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(coins)
        UserDefaults.standard.set(encoded, forKey: UserDefaults.Key.favouritesCoins)
        notifyObservers()
    }
    
    private func getCoins() throws -> [Coin] {
        guard let savedCoins = UserDefaults.standard.object(forKey: UserDefaults.Key.favouritesCoins) as? Data else {
            return []
        }
        let decoder = JSONDecoder()
        return try decoder.decode([Coin].self, from: savedCoins)
    }
}
