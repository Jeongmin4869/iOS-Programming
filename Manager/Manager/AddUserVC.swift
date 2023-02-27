import UIKit


class AddUserVC: UIViewController {
    
    
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var groupPicker: UIPickerView!
    
    @IBOutlet weak var calcelBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        mainLabel.text = "User"
        idLabel.text = "ID"
        pwLabel.text = "Password"
        
        calcelBtn.setTitle("Calcel", for: .normal)
        addBtn.setTitle("Add", for: .normal)
    }
    
    
    @IBAction func clickCalcelBtn(_ sender: Any) {
    }
    
    @IBAction func clickAddBtn(_ sender: Any) {
    }
    
    
}
