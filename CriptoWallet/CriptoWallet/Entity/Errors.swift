//
//  Errors.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 21.03.2022.
//

import Foundation

enum ValidationErrors: LocalizedError {
    case cantMap
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .cantMap:
            return "Mapping Error"
        case .serverError:
            return "Invalid data from server"
        }
    }
}
