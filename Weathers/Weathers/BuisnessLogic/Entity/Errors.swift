//
//  Errors.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 28.01.2022.
//
import Foundation

enum ValidationErrors: LocalizedError {
    case cantMap
 
    
    var errorDescription: String? {
        switch self {
        case.cantMap:
            return "Ошибка мепинга"
        }
    }
}


