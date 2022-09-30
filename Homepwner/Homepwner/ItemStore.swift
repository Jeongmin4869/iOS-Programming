//
//  ItemStore.swift
//  Homepwner
//
//  Created by 이정민 on 2022/09/25.
//

import UIKit
class ItemStore: NSObject{
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    override init() {
        super.init()
        for _ in 0..<5{
            self.createItem()
        }
    }
    
    func removeItem(index: Int){
        allItems.remove(at: index)
    }
    
    func moveItem(from: Int, to: Int){
        let item = allItems[from]
        allItems.remove(at: from)
        allItems.insert(item, at: to)
    }
    
}
