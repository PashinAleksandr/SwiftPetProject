//
//  CastomTableViewCell.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 21.07.2021.
//

import UIKit

class EditProductViewController: UIViewController, EditProductViewInput {
    var output: EditProductViewOutput!
    @IBOutlet weak var bodyProductTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    var productIndex: Int = 0
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = EditProductPresenter(view: self)
        setupStepper()
         
        bodyProductTextField.text = product.name
        numberLabel.text = product.count.description
    }
    
    func setupStepper() {
        stepper.value = Double(product.count)
        stepper.maximumValue = 100000000
        stepper.minimumValue = 1
    }

    @IBAction func changeNumberProduct(_ sender: UIStepper) {
        numberLabel.text = String(stepper.value)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveResult(_ sender: UIButton) {
        let count = Int(stepper.value)
        let name = bodyProductTextField.text ?? ""
        let product = Product(name: name, count: count)
        output.edit(product, index: productIndex)
    }
    
}
