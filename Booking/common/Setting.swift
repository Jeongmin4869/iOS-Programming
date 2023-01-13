//
//  Setting.swift
//  HW1
//
//  Created by Jae Moon Lee on 23/01/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import Foundation
public class Setting {
    var maxContinueBookingSlots: Int
    var maxTotalBookingSlots: Int // 최대 예약할수 있는 양
    
    
    init(){
        maxContinueBookingSlots = 2
        maxTotalBookingSlots = 4
    }
    
    init(str:String){
        
        maxContinueBookingSlots = 2
        maxTotalBookingSlots = 4
        
        let strs = str.components(separatedBy: "####")
        for str in strs {
            if str.count == 0 {
                continue
            }
            
            let components = str.components(separatedBy: ":")
            if components[0] == "maxContinueBookingSlots" {
                maxContinueBookingSlots = Int(components[1])!
            }
            if components[0] == "maxTotalBookingSlots" {
                maxTotalBookingSlots = Int(components[1])!
            }
        }
    }
    
    func toString() -> String{
        var str = ""
        str += "maxContinueBookingSlots:"+String(maxContinueBookingSlots) + "####"
        str += "maxTotalBookingSlots:"+String(maxTotalBookingSlots)
        return str
    }
}

