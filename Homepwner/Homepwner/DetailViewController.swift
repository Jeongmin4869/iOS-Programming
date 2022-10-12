//
//  DetailViewController.swift
//  Homepwner
//
//  Created by 이정민 on 2022/10/12.
//

import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    var Item: Item! // 이 뷰 컨트롤러의 뷰가 나타나기 전에 누군가 Assign할 수 있다
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = Item.name
        serialNumberField.text = Item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: Item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: Item.dateCreated as Date)
    }
    
    
}
