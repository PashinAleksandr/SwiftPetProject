//
//  Error Handling.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 08.10.2021.
//

import Foundation

enum DBError: LocalizedError {
    case canNotSave
    
    var errorDescription: String? {
        switch self {
        case .canNotSave:
            return "Can't save product"
        }
    }
}


enum SystemError: LocalizedError {
    case `default`
    
    var errorDescription: String? {
        return "Try again later"
    }
}

enum ValidationError: LocalizedError {
    case emptyProductName
    case emptyCount
    
    var errorDescription: String? {
        return "Введите текст"
    }

}

