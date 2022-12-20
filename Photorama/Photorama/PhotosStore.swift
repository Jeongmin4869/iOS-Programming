import UIKit
import CoreData

enum ImageResult{
    case Success(UIImage)
    case Failure(Swift.Error)
}
enum PhotoError: Swift.Error{
    case ImageCreationError
}


class PhotosStore{
    
    let coreDataStack = CoreDataStack(managedObjectModelName: "Photorama")
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    

    let imageStore = ImageStore()
    
    func fetchImageForPhoto(photo: Photo, completion: @escaping(ImageResult)->Void){
        
        //먼저 이미 저장되어있는지 체크
        let photoKey = photo.photoKey
        if let image = imageStore.imageForKey(key: photoKey){
            photo.image = image
            completion(.Success(image))
            return
        }
        
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            
            let result = self.processimageRequest(data: data, error: error)
            if case let .Success(image) = result {
                photo.image = image
                self.imageStore.setImage(image: image, forKey: photoKey)
            }
            completion(result)
            
            /*
            if let imageData = data {
                if let image = UIImage(data: imageData){
                    completion(ImageResult.Success(image))
                }else {
                    completion(ImageResult.Failure(PhotoError.ImageCreationError))
                }
            }else {
                completion(ImageResult.Failure(error!))
            }
            */
        }
        task.resume()
    }
    
    
    func fetchRecentPhotos(completion: @escaping (PhotosResult) -> Void){
        let url = FlickrAPI.recentPhotosURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request){
            
            (data, response, error) -> Void in
            
            /*
            if let jsonData = data{
                if let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue){
                    print(jsonString)
                }
            */
            
            /*
            if let jsonData = data{
                do{
                    let jsonObject: AnyObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as AnyObject
                    print(jsonObject)
                }catch let error{
                    print("Error creating JSON object: \(error)")
                }
            }else if let requestError = error {
                print("Error : fetching recent photos : \(requestError)")
            }else {
                print("Unexpected error with the request")
            }
            */
            
            //let result = FlickrAPI.photosFromJSONData(data: data!, context: self.coreDataStack.mainQueueContext)
            //새로운 것을 가져와 저장하고 이를 리턴
            var result = self.processRecentPhotosRequest(data: data, error: error)
            if case let .Success(photos) = result {
                let mainQueueContext = self.coreDataStack.mainQueueContext
                mainQueueContext.performAndWait(){
                    try! mainQueueContext.obtainPermanentIDs(for: photos)
                }
                //새로운 것들에 대하여 objectID만 추출
                let objectIDs = photos.map{$0.objectID}
                let predicate = NSPredicate(format: "self IN %@", objectIDs)
                let sortByDataTaken = NSSortDescriptor(key: "dataTaken", ascending: false)
                
                do{
                    try self.coreDataStack.saveChanges()
                    //새로운 것들만 다시 CoreData에서 가져온다.
                    let mainQueuePhotos = try self.fetchMainQueuePhotos(predicate: predicate, sortDescriptors :[sortByDataTaken])
                    result = .Success(mainQueuePhotos)
                }catch let error{
                    result = .Failure(error)
                }
            }
            completion(result)
             
        }
        task.resume()
    }
    
    func processRecentPhotosRequest(data:Data?, error:Error?) -> PhotosResult{
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photosFromJSONData(data: data!, context: self.coreDataStack.mainQueueContext)
    }
    
    
    func processimageRequest(data:Data?, error:Error?) -> ImageResult{
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photosFromJSONData(data: data!, context: self.coreDataStack.mainQueueContext)
 
    }
    
    
    func fetchMainQueuePhotos(predicate: NSPredicate? = nil, sortDescriptors:[NSSortDescriptor]? = nil) throws -> [Photo]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        let mainQueueContext = self.coreDataStack.mainQueueContext
        var mainQueuePhotos : [Photo]?
        var fetchRequestError: Swift.Error?
        
        mainQueueContext.performAndWait(){
            do {
                mainQueuePhotos = try mainQueueContext.fetch(fetchRequest) as! [Photo]
            }catch let error {
                fetchRequestError = error
            }
        }
        guard let photos = mainQueuePhotos else{
            throw fetchRequestError!
        }
        
        return photos
    }
}
