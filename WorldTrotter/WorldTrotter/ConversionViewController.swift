// import Foundation
import UIKit

class ConversionViewControlller : UIViewController {
    
    @IBOutlet var celsiusLabel: UILabel!
    
    @IBAction func fahrenheitEditingChanged(textField: UITextField){
        celsiusLabel.text = textField.text
    }
    
    
}

