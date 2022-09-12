// import Foundation
import UIKit

class ConversionViewControlller : UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    
    @IBAction func dismissKeyboard(sender: AnyObject){
        textField.resignFirstResponder()
    }
    
    // 1
    @IBAction func fahrenheitEditingChanged(textField: UITextField){
        
        if let text = textField.text, let value = Double(text){
            fahrenheitVlaue = value
        }
        else{
            fahrenheitVlaue = nil
        }
    }
    
    // 3
    func updateCelsiusLabel(){
        if let value = celsiusValue{
            //celsiusLabel.text = "\(value)"'
            //celsiusLabel.text = String.init(format: "%.2f", value)
            celsiusLabel.text = numberFormatter.string(from: NSDecimalNumber(decimal: Decimal(value)))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    // 4
    var celsiusValue: Double? {
        if let value = fahrenheitVlaue{
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    // 2
    var fahrenheitVlaue: Double?{
        didSet{
            updateCelsiusLabel()
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumIntegerDigits = 0
        nf.maximumIntegerDigits = 1 // 소수점 뒤로 최대 1개까지
        return nf
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let decimalDigits = CharacterSet.decimalDigits
        for char in string.unicodeScalars{
            if !decimalDigits.contains(char){
                print("문자포함\n")
                return false;
            }
        }
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil{
            return false
        }
        else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
}

