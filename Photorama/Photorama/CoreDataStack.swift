import CoreData
import UIKit

class CoreDataStack{
    let managedObjectModelName: String
    required init(managedObjectModelName: String) {
        self.managedObjectModelName = managedObjectModelName
    }
    
    //CoreData와 momd파일을 연결
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: self.managedObjectModelName, withExtension: "momd")
        return NSManagedObjectModel(contentsOf: modelURL)
    }()
    
    //CoreData에 대한 위치(디렉토리)를 관리
    private lazy var persistentStoreCoordinator = {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        url = url?.appendingPathExtension("\(managedObjectModelName).sqlite")
        
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options:nil)
        return coordinator
    }
    
    //CoreData 기능이 실행
    lazy var mainQueueContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        managedObjectContext.name = "Main Queue Context (UI Context) "
        return managedObjectContext
    }
    
}
