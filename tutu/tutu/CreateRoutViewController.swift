//
//  CreatRoutViewController.swift
//  tutu
//
//  Created by Aleksandr Pashin on 12.10.2021.
//

import UIKit

class CreateRouteViewController: UIViewController, CreateRouteViewInput, UIViewInput {
    @IBOutlet weak var departurePointTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var dastinationTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    var output: CreateRouteViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = CreateRoutePresenter(view: self)
        dateTextField.inputView = datePicker
        hideKeyboardWhenSuperviewTapped()
    }
    
    func defaultValue() {
        departurePointTextField.text = ""
        dastinationTextField.text = ""
        noteTextView.text = ""
        dateTextField.text = ""
    }
    
    @IBAction func creatRoute(_ sender: UIButton) {
        let departurePoint = departurePointTextField.text ?? ""
        let dastination = dastinationTextField.text ?? ""
        let note = noteTextView.text ?? ""
        let date = datePicker.date
        let route = Route(dastenation: dastination, departurePoint: departurePoint, departureDate: date, note: note)
        output.save(route)
    }
    
    @IBAction func dateDidChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("d MMMM yyyy")
        dateTextField.text = dateFormatter.string(from: date)
    }
    
    @IBAction func textFielddidChanged(_ sender: UITextField) {
        dateTextField.text = DateFormatter.myDateFormatter.string(from: datePicker.date)
    }
    
}
