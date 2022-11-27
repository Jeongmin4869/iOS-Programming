import Foundation

class PhotosStore{
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
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
                    print(jsonData)
                }catch let error{
                    print("Error creating JSON object: \(error)")
                }
            }else if let requestError = error {
                print("Error : fetchibgn recdent photos : \(requestError)")
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
