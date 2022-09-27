//
//  ItemsViewController.swift
//  Homepwner
//

import UIKit

class ItemsViewController : UITableViewController{
    var itemStore: ItemStore! // reference
    
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
    
}
