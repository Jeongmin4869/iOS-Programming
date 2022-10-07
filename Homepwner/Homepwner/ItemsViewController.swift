//
//  ItemsViewController.swift
//  Homepwner
//

import UIKit

class ItemsViewController : UITableViewController{
    var itemStore: ItemStore! // reference
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

        print("hegith : \(height)")
        print("statusBarHeight : \(statusBarHeight)")
        
        let insets = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        /*코드추가. 그러나 별다른 변화 없음*/
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        
        let item = itemStore.allItems[indexPath.row]
        
        //cell!.textLabel?.text = item.name
        //cell!.detailTextLabel?.text = String(item.valueInDollars)
        cell.nameLabel?.text = item.name
        cell.serialNumberLabel?.text = item.serialNumber
        cell.valueLabel?.text = "$\(item.valueInDollars)"
        return cell
    }
    
    /* 셀 높이 지정 에러 해결방법 */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //temStore.removeItem(index: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action)->Void in
                self.itemStore.removeItem(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            present(alertController, animated: true, completion: nil)
 
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row , to: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    @IBAction func addNewItem(sender: AnyObject){
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func ToggleEditingMode(sender: AnyObject){
        if isEditing{
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }
        else{
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }

}
