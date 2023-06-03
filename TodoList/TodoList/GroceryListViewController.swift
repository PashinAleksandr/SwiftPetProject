//
//  ViewController.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 21.07.2021.
//

import UIKit
import CoreData

class GroceryListViewController: UIViewController, GroceryListViewInput {
    @IBOutlet weak var deleteProductBarButton: UIBarButtonItem!
    @IBOutlet weak var whenEmptyProductsLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var output: GroceryListViewOutput!
    
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        output = GroceryListPresenter(view: self)

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editVC = segue.destination as? EditProductViewController {
            editVC.productIndex = selectedIndex
            let products = output.getProducts()
            editVC.product = products[selectedIndex]
        }
        //if let vsc = segue.destination as? CreateProductViewController {
        //}
    }
    
    @IBAction func deleteProduct(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Are you shure?", message: "All products will be deleted", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "delete all", style: .destructive) { _ in
            self.output.deleteAllProducts()
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: UIButton) {
        let productList: String = output.prepareDataForShare()
        let activityVC = UIActivityViewController(activityItems: [productList], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    func switchTo(state: ViewState) {
        switch state {
        case .default:
            whenEmptyProductsLabel.isHidden = true
            shareButton.isHidden = false
            deleteProductBarButton.isEnabled = true
            tableView.isHidden = false
        case .emptyList:
            whenEmptyProductsLabel.isHidden = false
            shareButton.isHidden = true
            deleteProductBarButton.isEnabled = false
            tableView.isHidden = true
        }
    }
    
}

extension GroceryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let products = output.getProducts()
        return products.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "EditViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryTableViewCell") as? GroceryTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        let products = output.getProducts()
        let product = products[index]
        cell.fill(with: product, index: index)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            output.deleteProduct(indexPath.row)
            tableView.deselectRow(at: [indexPath.row], animated: true)
            tableView.reloadData()
        }
    }
    
}

extension GroceryListViewController {
    enum ViewState {
        case emptyList
        case `default`
    }
}
