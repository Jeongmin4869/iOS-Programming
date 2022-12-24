//
//  ViewController.swift
//  Login
//
//  Created by 이정민 on 2022/12/15.
//

import UIKit

class LoginViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, DatabaseDelegate  {
    
    @IBOutlet weak var button: UIButton! {
        didSet{
            button.setTitleColor(UIColor.gray, for: .normal)
            button.isEnabled = false
        }
    }
    
    @IBOutlet weak var groupPickerView: UIPickerView!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!

    @IBOutlet weak var toggle: UISwitch!
    
    
    func onChange(groupDatabaseStr: String) {
        groupDatabase = databaseBroker.loadGroupDatabase()
        
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        groupPickerView.reloadComponent(0)
        //button.isEnabled = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupDatabase.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groupDatabase[row]
    }
    
    var groupDatabase: [String]!
    var databaseBroker: DatabaseBroker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.idTextField.delegate = self
        self.pwTextField.delegate = self
        
        databaseBroker = DatabaseObject.createDatabase(rootPath: "test")
        databaseBroker.setGroupDataDelegate(dataDelegate: self)
    }

    @IBAction func onButtonClicked(_ sender: Any) {
        if pwTextField.text?.isEmpty == true{
            Message.information(parent: self, title: "Caution", message: "Enter your password.")
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == idTextField{
            if textField.text?.isEmpty == true{
                button.setTitleColor(UIColor.gray, for: .normal)
                button.isEnabled = false
            }
            else {
                button.setTitleColor(UIColor.blue, for: .normal)
                button.isEnabled = true
            }
        }
    }
    
    @IBAction func pressToggle(_ sender: Any) {
        if toggle.isOn{
            //admin
        }
        else {
            //user
        }
    }
    
}

