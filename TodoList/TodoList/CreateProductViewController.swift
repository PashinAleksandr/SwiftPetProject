//
//  CrateTaskViewController.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 10.08.2021.
//

import UIKit

class CreateProductViewController: UIViewController, CreatProductViewInput {
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var bodyProductTextField: UITextField!
    @IBOutlet weak var numberProductLabel: UILabel!
    var output: CreatProductViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        output = CreateProductPresenter(view: self)
        setupInitialState()
    }
    
    func setupInitialState() {
        numberProductLabel.text = stepper.value.description
        setupStepper()
        resetFields()
    }
    
    func resetFields() {
        stepper.value = 1
        bodyProductTextField.text = ""
        numberProductLabel.text = "1"
    }
    
    func setupStepper() {
        stepper.minimumValue = 1
        stepper.maximumValue = 100000000
    }
    
    @IBAction func changeValueProduct(_ sender: UIStepper) {
        numberProductLabel.text = String(stepper.value)
    }
    
    @IBAction func addProduct(_ sender: UIButton) {
        let count = Int(stepper.value)
        let name = bodyProductTextField.text ?? ""
        let product = Product(name: name, count: count)
        output.save(product)
    }
    
}
