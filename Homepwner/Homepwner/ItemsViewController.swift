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
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
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
    
}
