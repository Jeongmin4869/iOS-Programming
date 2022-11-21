import Foundation

class PhotosStore{
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(){
        let url = FlickrAPI.recentPhotosURL()
        let request = URLRequest(url: url)
        
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: {
            
            (data, request, error) -> Void in
            
            
            if let jsonData = data{
                if let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue){
                    print(jsonData)
                }
            }else if let requestError = error {
                print("Error : fetchibgn recdent photos : \(requestError)")
            }else {
                print("Unexpected error with the request")
            }
            
        })
        
        task.resume()
    }
    
}
