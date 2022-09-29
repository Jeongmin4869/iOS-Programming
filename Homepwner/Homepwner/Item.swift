//
//  Item.swift
//  Homepwner
//

import UIKit

class Item : NSObject{
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    
    init(name: String, serialNumber: String?, valueInDollars: Int){
            
            self.name = name
            self.valueInDollars = valueInDollars
            self.serialNumber = serialNumber
            self.dateCreated = NSDate()
            
            super.init()
    }
    
    init(random: Bool = false){
        
        if random == false {
            //self.init(name:"", serialNumber: nil, valueInDollars:0)
            self.name = ""
            self.valueInDollars = 0
            self.serialNumber = nil
            self.dateCreated = NSDate()
            
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
        
        //self.init(name:randomName, serialNumber:randomSerial, valueInDollars:randomValue)
        self.name = randomName
        self.serialNumber = randomSerial
        self.valueInDollars = randomValue
        self.dateCreated = NSDate()
        
        super.init()

    }
}
