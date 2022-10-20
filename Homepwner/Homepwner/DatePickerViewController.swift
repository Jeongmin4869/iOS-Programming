import UIKit

class DatePickerViewController: UIViewController {
    var item: Item!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        datePicker.date = item.dateCreated as Date
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date as NSDate
    }
    
}
