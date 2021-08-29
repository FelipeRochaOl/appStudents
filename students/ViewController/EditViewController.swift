//
//  EditViewController.swift
//  students
//
//  Created by Felipe Rocha Oliveira on 24/08/21.
//

import UIKit

// create protocol to update people in view controller after editing
protocol EditViewControllerProtocol: AnyObject {
    func updatePeople()
}

class EditViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    
    weak var delegate: EditViewControllerProtocol?
    
    var selectedPeople: People? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = "Name:"
        self.lastnameLabel.text = "Lastname:"
        self.ageLabel.text = "Age:"
        self.emailLabel.text = "E-mail:"
        self.generoLabel.text = "Genero"
        
        //get people to class
        if let _selectedPeople = self.selectedPeople {
            self.titleLabel.text = "Edit User - \(_selectedPeople.name ?? "")"
            self.nameTextField.text = _selectedPeople.name
            self.lastnameTextField.text = _selectedPeople.lastname
            self.ageTextField.text = String(_selectedPeople.age ?? 0)
            self.emailTextField.text = _selectedPeople.email
            self.generoTextField.text = _selectedPeople.genero?.rawValue
        }
        
        //initial delegates
        self.nameTextField.delegate = self
        self.lastnameTextField.delegate = self
        self.ageTextField.delegate = self
        self.emailTextField.delegate = self
        self.generoTextField.delegate = self
        
        // init view with focus in field nameTextField
        self.nameTextField.becomeFirstResponder()
        // keyboard only numbers
        self.ageTextField.keyboardType = .decimalPad
        // create button in field
        self.addButtonOnKeyBoard("Done", self.ageTextField)
        self.addButtonOnKeyBoard("Save", self.generoTextField)
    }
    
    private func addButtonOnKeyBoard(_ text: String, _ field: UITextField) {
        // create toolbar
        let toolBar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        toolBar.barStyle = .default
        
        // create buttons to toolbar
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var doneButton = UIBarButtonItem(title: text, style: .done, target: self, action: #selector(self.doneButtonTapped))
        
        if text == "save" {
            doneButton = UIBarButtonItem(title: text, style: .done, target: self, action: #selector(self.saveButtonTapped))
        }
        
        let items = [flexSpace, doneButton] // flexSpace calculation space in white
        toolBar.items = items
        toolBar.sizeToFit()
        
        field.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped() {
        self.emailTextField.becomeFirstResponder()
    }
    
    @objc func saveButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension EditViewController: UITextFieldDelegate {
    
    //Protocol to textfield in clicked return from keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // init view with focus in field nameTextField
        if textField == nameTextField {
            self.lastnameTextField.becomeFirstResponder()
        } else if textField == lastnameTextField {
            self.ageTextField.becomeFirstResponder()
        } else if textField == ageTextField {
            self.emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            self.generoTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            self.delegate?.updatePeople()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case self.nameTextField:
            self.selectedPeople?.name = textField.text
        case self.lastnameTextField:
            self.selectedPeople?.lastname = textField.text
        case self.ageTextField:
            self.selectedPeople?.age = Int(textField.text ?? "0")
        case self.emailTextField:
            self.selectedPeople?.email = textField.text
        default:
            self.selectedPeople?.genero = Genero(rawValue: textField.text ?? "")
            self.delegate?.updatePeople()
        }
    }
    
}
