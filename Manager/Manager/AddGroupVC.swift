import UIKit

class AddGroupVC: UIViewController{
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        mainLabel.text = "Add Group"
        label.text = "group"
        cancleBtn.setTitle("Cancle", for: .normal)
        addBtn.setTitle("Add", for: .normal)
    }
    
    @IBAction func clickCancleBtn(_ sender: Any) {
    }
    
    
    @IBAction func clickAddBtn(_ sender: Any) {
    }
    
}
