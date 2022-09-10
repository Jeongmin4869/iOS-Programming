// import Foundation
import UIKit

class ConversionViewControlller : UIViewController {
    
    @IBOutlet var celsiusLabel: UILabel!
    
    @IBAction func fahrenheitEditingChanged(textField: UITextField){
        
        if let text = textField.text, !text.isEmpty{
            celsiusLabel.text = textField.text
        }
        else{
            celsiusLabel.text = "???"
        }
    }
}

