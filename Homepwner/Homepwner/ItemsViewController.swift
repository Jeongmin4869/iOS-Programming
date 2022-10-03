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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let item = itemStore.allItems[indexPath.row]
        cell!.textLabel?.text = item.name
        cell!.detailTextLabel?.text = String(item.valueInDollars)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            itemStore.removeItem(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
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
