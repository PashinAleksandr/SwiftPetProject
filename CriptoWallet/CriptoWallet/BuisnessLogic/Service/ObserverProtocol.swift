//
//  ObserverProtocol.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 15.07.2022.
//

import Foundation

protocol Observable: AnyObject {
    func registration(observer: Observer)
    func remove(observer: Observer)
}
