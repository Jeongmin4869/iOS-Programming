import UIKit

protocol saveUserDelegate {
    func sendData(data: String)
}


class AddUserVC: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var groupPicker: UIPickerView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    var delegate: saveUserDelegate?
    
    override func viewDidLoad() {
        mainLabel.text = "User"
        idLabel.text = "ID"
        pwLabel.text = "PW"
        idLabel.textAlignment = .right
        pwLabel.textAlignment = .right
        mainLabel.font = UIFont.systemFont(ofSize: 30)
        mainLabel.frame.size.width = 200
        mainLabel.textAlignment = .center
        idLabel.font = UIFont.systemFont(ofSize: 15)
        pwLabel.font = UIFont.systemFont(ofSize: 15)
        
        cancelBtn.setTitle("Calcel", for: .normal)
        cancelBtn.frame.size.width = 100
        addBtn.setTitle("Add", for: .normal)
    }
    
    
    @IBAction func clickCalcelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func clickAddBtn(_ sender: Any) {
        
    }
    
    
}
