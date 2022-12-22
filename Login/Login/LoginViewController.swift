//
//  ViewController.swift
//  Login
//
//  Created by 이정민 on 2022/12/15.
//

import UIKit

class LoginViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate DatabaseDelegate  {
    
    @IBOutlet weak var button: UIButton! {
        didSet{
            button.isEnabled = false
            button.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    @IBOutlet weak var groupPickerView: UIPickerView!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    
    func onChange(groupDatabaseStr: String) {
        groupDatabase = databaseBroker.loadGroupDatabase()
        
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        groupPickerView.reloadComponent(0)
        button.isEnabled = true
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
        databaseBroker = DatabaseObject.createDatabase(rootPath: "test")
        databaseBroker.setGroupDataDelegate(dataDelegate: self)
    }

    @IBAction func onButtonClicked(_ sender: Any) {
        /*
        let str = groupDatabase[groupPickerView.selectedRow(inComponent: 0)]+"가 선택되었습니다"
        Message.information(parent: self, title: "확인", message: str)
        */
    }
    
}

