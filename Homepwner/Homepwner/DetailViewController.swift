//
//  DetailViewController.swift
//  Homepwner
//
//  Created by 이정민 on 2022/10/12.
//

import UIKit

class DetailViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var item: Item!{
        didSet{
            navigationItem.title = item.name
        }
    }
    
    
    let numberFormatter: NumberFormatter={
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        serialNumberField.delegate = self
        valueField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        item.valueInDollars = 0
        if let valueText = valueField.text{
            let value = numberFormatter.number(from:  valueText)
            item.valueInDollars = (value?.intValue)!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
        
        navigationItem.title = item.name
        
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true) // UITextField에 관계없이 키보드를 숨긴다
        
        //nameField.resignFirstResponder()
        //serialNumberField.resignFirstResponder()
        //valueField.resignFirstResponder()
    
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
    }
    
    
    //prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DatePicker"{
            let datePickerViewController = segue.destination as! DatePickerViewController
            datePickerViewController.item = item
        }
    }
    

}
