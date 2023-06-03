//
//  EditRouteViewController.swift
//  tutu
//
//  Created by Aleksandr Pashin on 12.10.2021.
//

import UIKit

class EditRouteViewController: UIViewController, EditRouteViewImput {
    @IBOutlet weak var departurePointTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var dateTextField: UITextField!
    
    var output: EditRouteViewOutput!
    var selectedIndex: Int = 0
    var route: Route!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = EditRoutePresenter(view: self)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("d MMMM yyyy")
        
        departurePointTextField.text = route.departurePoint
        destinationTextField.text = route.dastenation
        noteTextView.text = route.note
        dateTextField.text = dateFormatter.string(from: route.departureDate)
        
        hideKeyboardWhenSuperviewTapped()
    }
    
    func defolteValue() {
        departurePointTextField.text = ""
        destinationTextField.text = "" 
        noteTextView.text = ""
        dateTextField.text = ""
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        let departurePoint = departurePointTextField.text ?? ""
        let destination = destinationTextField.text ?? ""
        let note = noteTextView.text ?? ""
        let date = datePicker.date
        let route = Route(dastenation: destination, departurePoint: departurePoint, departureDate: date, note: note)
        output.edit(route, index: selectedIndex)
        back()
    }
    
    @IBAction func dateDidChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("d MMMM yyyy")
        dateTextField.text = dateFormatter.string(from: date)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
