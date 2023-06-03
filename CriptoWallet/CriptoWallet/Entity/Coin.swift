//
//  Coin.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 21.03.2022.
//

import Foundation
import UIKit

struct Coin: Codable {
    var capitalization: String
    var changeForDay: Double
    var proposal: Double
    var changePrice: Double
    var confirmationAlgorithm: String
    var price: Double
    var hasingAlgorithm: String
    var fullCoinName: String
    var shortCoinName: String
    var iconURL: URL?
    
    init() {
        capitalization = "0"
        changeForDay = 0
        proposal = 0
        changePrice = 0
        confirmationAlgorithm = "0"
        price = 0
        hasingAlgorithm = "0"
        fullCoinName = "0"
        shortCoinName = "0"
        iconURL = nil
    }
    
    init(json: [String: Any]) throws {
        guard
              let coinInfo = json["CoinInfo"] as? [String: Any],
              let coinName = coinInfo["FullName"] as? String,
              let shortCoinName = coinInfo["Name"] as? String,
              let hasingAlgorithm = coinInfo["Algorithm"] as? String,
              let RAW = json["RAW"] as? [String: Any],
              let USD = RAW["USD"] as? [String: Any],
              let price = USD["PRICE"] as? Double,
              let confirmationAlgorithm = coinInfo["ProofType"] as? String,
              let display = json["DISPLAY"] as? [String: Any],
              let USDdisplay = display["USD"] as? [String: Any],
              let changePrice = USD["CHANGEDAY"] as? Double,
              let changeForDay = USD["CHANGEPCT24HOUR"] as? Double,
              let proposal = USD["PRICE"] as? Double,
              let capitalization = USDdisplay["MKTCAP"] as? String,
              let icon = USD["IMAGEURL"] as? String
        else {
            throw ValidationErrors.cantMap
        }
        self.capitalization = capitalization
        self.changeForDay = changeForDay
        self.proposal = proposal
        self.changePrice = changePrice
        self.confirmationAlgorithm = confirmationAlgorithm
        self.price = price
        self.hasingAlgorithm = hasingAlgorithm
        self.fullCoinName = coinName
        self.shortCoinName = shortCoinName
        self.iconURL = URL(string: "https://www.cryptocompare.com" + icon)
    }
}

extension Coin {
    static func ==(lhs: Coin, rhs: Coin) -> Bool {
        
        lhs.capitalization == rhs.capitalization &&
        lhs.changeForDay == rhs.changeForDay &&
        lhs.proposal == rhs.proposal &&
        lhs.changePrice == rhs.changePrice &&
        lhs.confirmationAlgorithm == rhs.confirmationAlgorithm &&
        lhs.price == rhs.price &&
        lhs.hasingAlgorithm == rhs.hasingAlgorithm &&
        lhs.fullCoinName == rhs.fullCoinName &&
        lhs.shortCoinName == rhs.shortCoinName
    }
}
