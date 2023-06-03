//
//  ViewController.swift
//  tutu
//
//  Created by Aleksandr Pashin on 12.10.2021.
//

import UIKit

class RouteViewController: UIViewController, RouteViewInput, UIViewInput {

    @IBOutlet weak var creatRouteButtonItem: UIBarButtonItem!
    @IBOutlet weak var deleteAllRouteButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var whenEmptyLabel: UILabel!
    
    var output: RouteViewOutput!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = RoutePresenter(view: self)
        
        let nib = UINib(nibName: "RouteTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RouteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }
    
    @IBAction func deleteAllRoute(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Удалить все маршруты?", message: "Маршруты будут удалены!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Удвлить", style: .destructive) { _ in
            self.output.deleteAllRoute()
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
    
    func switchTo(state: ViewState) {
        switch state {
        case.defolte:
            whenEmptyLabel.isHidden = true
            deleteAllRouteButtonItem.isEnabled = true
        case.emptyRouteSheet:
            whenEmptyLabel.isHidden = false
            deleteAllRouteButtonItem.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editeViewController = segue.destination as? EditRouteViewController {
            editeViewController.selectedIndex = selectedIndex
            let routes = output.getRoute()
            editeViewController.route = routes[selectedIndex]
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {}
    
    func updateTable() {
        tableView.reloadData()
    }
}

extension RouteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "EditRouteViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let routes = output.getRoute()
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RouteTableViewCell") as? RouteTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        let routes = output.getRoute()
        let route = routes[index]
        cell.fill(route: route, index: index)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            output.deleteRoute(indexPath.row)
            tableView.reloadData()
        }
    }
}

extension RouteViewController {
    enum ViewState{
        case emptyRouteSheet
        case `defolte`
    }
}
