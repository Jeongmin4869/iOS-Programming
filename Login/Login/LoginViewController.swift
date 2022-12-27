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
    @IBOutlet weak var resetPwButton: UIButton!
    @IBOutlet weak var groupPickerView: UIPickerView!
    @IBOutlet weak var pwTextField: UITextField!{
        didSet{
            //문자 입력이 들어오면 바로 이전값은 hide(*)상태로 변경
            pwTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var idTextField: UITextField!

    @IBOutlet weak var toggle: UISwitch!{
        didSet{
            toggle.isOn = false
        }
    }
    
    var groupDatabase: [String]!
    var userDatabase: [User]!
    var databaseBroker: DatabaseBroker!
    
    func onChange(groupDatabaseStr: String) {
        groupDatabase = databaseBroker.loadGroupDatabase()
        
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        groupPickerView.reloadComponent(0)
        //button.isEnabled = true
    }
    
    
    func onChange(userDatabaseStr: String) {
        userDatabase = databaseBroker.loadUserDatabase()
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.idTextField.delegate = self
        self.pwTextField.delegate = self
        
        databaseBroker = DatabaseObject.createDatabase(rootPath: "test")
        databaseBroker.setGroupDataDelegate(dataDelegate: self)
        databaseBroker.setUserDataDelegate(dataDelegate: self)
    }

    @IBAction func onButtonClicked(_ sender: Any) {
        if pwTextField.text?.isEmpty == true{
            Message.information(parent: self, title: "Caution", message: "Enter your password.")
        }
        
        let gourp = groupDatabase[groupPickerView.selectedRow(inComponent: 0)]
    
        for userdata in userDatabase {
            
            //admin계정으로 로그인 할 수 없음
            if userdata.name == "root" && toggle.isOn == false{
                Message.information(parent: self, title: "Caution", message: " Not permitted to log in.")
            }
            
            //사용자 유무 확인
            if userdata.isMe(name: idTextField.text!) == false {
                continue
            }
            
            //로그인이 성공했을 경우
            if userdata.isMe(name: idTextField.text! , password: pwTextField.text! , group: gourp) == true{
                Message.information(parent: self, title: "", message: "Signed in successfully.")
            }
            //로그인이 실패했을 경우
            else {
                //실패원인1. 비밀번호 불일치
                if userdata.isMe(password: pwTextField.text!) == false{
                    Message.information(parent: self, title: "Failed", message: "Invalid password. Please try again.")
                }
                //실패원인2. 소속 불일치
                if userdata.isMe(name: idTextField.text!, group: gourp) == false{
                    Message.information(parent: self, title: "Failed", message: "Invalid group. Please try again.")
                }
                
            }
        }
        
        //실패원인3. 사용자없음
        Message.information(parent: self, title: "Failed", message: "ID does not exist. Please try again.")
        
    }
    
    @IBAction func resetPwButtonClicked(_ sender: Any){
        Message.information(parent: self, title: "Caution", message: ".")
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
        pwTextField.text = ""
        if toggle.isOn{
            //root
            idTextField.text = "root"
            idTextField.isEnabled = false;
            button.isEnabled = true;
        }
        else {
            //user
            idTextField.text = ""
            idTextField.isEnabled = true;
            button.isEnabled = false;
        }
    }
    
}

