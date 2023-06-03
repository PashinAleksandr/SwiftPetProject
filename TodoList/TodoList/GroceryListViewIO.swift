//
//  GroceryViewIO.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 15.09.2021.
//

import Foundation

protocol GroceryListViewInput: AnyObject, UIViewInput {
    func switchTo(state: GroceryListViewController.ViewState)
    func updateTable()
}

protocol GroceryListViewOutput {
    func deleteAllProducts()
    func deleteProduct(_ SelectedIndex: Int)
    func prepareDataForShare() -> String
    func getProducts() -> [Product] 
    func viewWillAppear()
}
