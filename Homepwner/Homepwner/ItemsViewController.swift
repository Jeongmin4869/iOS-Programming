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
}
