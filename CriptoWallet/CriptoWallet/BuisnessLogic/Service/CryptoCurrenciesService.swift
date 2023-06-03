//
//  CryptoCurrenciesService.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 14.03.2022.
//
import Alamofire
import Foundation

func isDebug() -> Bool {
    var isDebug: Bool!
#if DEBUG
    isDebug = true
#else
    isDebug = false
#endif
    return isDebug
}

class Config {
    enum API {
        static let apiKey: String = {
            return isDebug() ? "8deaf49016ccd565f4a378c9b8d4af163dfccd4da1b06e5383381dd33bf5da92" : "8deaf49016ccd565f4a378c9b8d4af163dfccd4da1b06e5383381dd33bf5da92"
        }()
    }
}

protocol CryptoCurrenciesServiceProtocol: AnyObject {
    func fatchCryptoCurrencies(completionHandler: @escaping ([Coin]?, Error?) -> Void)
}

class CryptoCurrenciesService: CryptoCurrenciesServiceProtocol {
    
    static let shared = CryptoCurrenciesService()
    
    var currencies: [Coin] = []
    
    private init() {
        currencies = []
    }
    
    let apiID: String = Config.API.apiKey
    
    func fatchCryptoCurrencies(completionHandler: @escaping ([Coin]?, Error?) -> Void) {
        let params: Parameters = ["limit": 99, "tsym": "USD", "api_key": apiID]
        AF.request("https://min-api.cryptocompare.com/data/top/mktcapfull", method: .get, parameters: params).response { response in
            do {
                guard let data = response.data,
                      let jeson = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let dataInfo = jeson["Data"] as? [[String: Any]] else {
                    throw ValidationErrors.cantMap
                }
                
                let coins = dataInfo.compactMap({ try? Coin(json: $0) })
                
                if coins.isEmpty {
                    throw ValidationErrors.serverError
                } else {
                    completionHandler(coins, nil)
                }
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
}

