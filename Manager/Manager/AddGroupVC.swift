import UIKit


//1. 데이터를 넘기는 함수 원형만 적고, 구현부는 이전 뷰에서 진행
protocol sendNewGroupNM {
  func dataSend(data: String)
}

class AddGroupVC: UIViewController{
    
    var delegate: sendNewGroupNM?
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        mainLabel.text = "Add Group"
        label.text = "group"
        cancleBtn.setTitle("Cancle", for: .normal)
        cancleBtn.frame.size.width = 100
        addBtn.setTitle("Add", for: .normal)
    }
    
    @IBAction func clickCancleBtn(_ sender: Any) {
        print("clickCancleBtn")
        self.dismiss(animated: true)
    }
    
    
    @IBAction func clickAddBtn(_ sender: Any) {
        print("clickAddBtn")
        if let text = textField.text {
            delegate?.dataSend(data: text)
        }
        self.dismiss(animated: true)
    }
    
}
