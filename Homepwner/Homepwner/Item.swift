//
//  Item.swift
//  Homepwner
//

import UIKit

class Item : NSObject, NSCoding{
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: NSDate
    
    var itemKey: String //let itemKey: String
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! NSDate
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
    }
    
    
    init(name: String, serialNumber: String?, valueInDollars: Int){
            
            self.name = name
            self.valueInDollars = valueInDollars
            self.serialNumber = serialNumber
            self.dateCreated = NSDate()
            self.itemKey = NSUUID().uuidString
            
            super.init()
    }
    
    init(random: Bool = false){
        
        if random == false {
            //self.init(name:"", serialNumber: nil, valueInDollars:0)
            self.name = ""
            self.valueInDollars = 0
            self.serialNumber = nil
            self.dateCreated = NSDate()
            self.itemKey = ""
            
            super.init()
            return
        }
        
        let adjectives = ["Fluffy", "Rusty", "Shiny"]
        let nouns = ["Bear", "Spork","Mac"]
        
        var index = Int(arc4random_uniform(UInt32(adjectives.count)))
        let randdomAdjective = adjectives[index]
        
        index = Int(arc4random_uniform(UInt32(nouns.count)))
        let randdomNoun = nouns[index]
        
        let randomName = "\(randdomAdjective)\(randdomNoun)"
        let randomValue = Int(arc4random_uniform(100))
        let randomSerial = NSUUID().uuidString.components(separatedBy: "-").first!
        let uuid = NSUUID().uuidString
        
        //self.init(name:randomName, serialNumber:randomSerial, valueInDollars:randomValue)
        self.name = randomName
        self.serialNumber = randomSerial
        self.valueInDollars = randomValue
        self.dateCreated = NSDate()
        self.itemKey = uuid
        
        super.init()

    }
}
