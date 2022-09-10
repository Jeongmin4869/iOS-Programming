// import Foundation
import UIKit

class ConversionViewControlller : UIViewController {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheitEditingChanged(textField: UITextField){
        
        if let text = textField.text, !text.isEmpty{
            celsiusLabel.text = textField.text
        }
        else{
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject){
        textField.resignFirstResponder()
    }
    
}

