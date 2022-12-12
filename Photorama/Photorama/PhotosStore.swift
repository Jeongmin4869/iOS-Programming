import UIKit

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
    
    func fetchImageForPhoto(photo: Photo, completion: @escaping(ImageResult)->Void){
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            if let imageData = data {
                if let image = UIImage(data: imageData){
                    completion(ImageResult.Success(image))
                }else {
                    completion(ImageResult.Failure(PhotoError.ImageCreationError))
                }
            }else {
                completion(ImageResult.Failure(error!))
            }
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
            
            let result = FlickrAPI.photosFromJSONData(data: data!)
            completion(result)
             
        }
        task.resume()
    }
    
}
