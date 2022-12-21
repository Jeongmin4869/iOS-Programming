import UIKit
import Foundation

@objc protocol DatabaseDelegate{
    @objc optional func onChange(groupDatabaseStr:String)
    @objc optional func onChange(userDatabaseStr:String)
    @objc optional func onChange(settingDatabaseStr:String)
    @objc optional func onChange(bookingDatabaseStr:String)
    @objc optional func onChange(databaseRootStr:String)
}

protocol DatabaseBroker {
    func setGroupDataDelegate(dataDelegate: DatabaseDelegate?)
    func loadGroupDatabase() -> [String];
    func saveGroupDatabase(groupDatabase: [String]?)
    
    func setUserDataDelegate(dataDelegate: DatabaseDelegate?)
    func loadUserDatabase() -> [User]
    func saveUserDatabase(userDatabase: [User]?)
    
    func setBookingDataDelegate(userGroup: String, dataDelegate: DatabaseDelegate?)
    func loadBookingDatabase(userGroup: String) -> [String]
    func saveBookingDatabase(userGroup: String, bookingDatabase: [String])
    
    func setSettingDataDelegate(dataDelegate: DatabaseDelegate?)
    func loadSettingDatabase() -> Setting
    func saveSettingDatabase(settingDatabase: Setting)
    
    func setCheckDatabaseRoot(dataDelegate: DatabaseDelegate?)
    func resetDatabase()
}

class DatabaseObject{
    public var rootPath: String = "test"
    
    public static func createDatabase(rootPath: String) -> DatabaseBroker {
        //self.rootPath = rootPath
        var databaseObject: DatabaseObject!
        
        if rootPath == "test" {
            databaseObject = FilebaseBroker()
        }else{
            databaseObject = FilebaseBroker() // it will be replaced as FirebaseBroker
        }
        databaseObject.rootPath = rootPath
        
        return databaseObject! as! DatabaseBroker
    }
}
