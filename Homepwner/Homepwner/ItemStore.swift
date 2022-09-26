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
}
