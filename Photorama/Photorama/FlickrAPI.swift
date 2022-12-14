//
//  FlickrAPI.swift
//  Photorama
//
//  Created by 이정민 on 2022/11/17.
//

import Foundation
import UIKit
import CoreData

enum Method: String{
    case RecentPhotos = "flickr.photos.getRecent"
}

enum PhotosResult{
    case Success([Photo])
    case Failure(Swift.Error)
}

enum FlickrError: Swift.Error{
    case InvalidJSONData
}


struct FlickrAPI{
    private static let baseURLString = "https://api.flickr.com/services/rest/"
    private static let APIKey = "b9afcfd5008c8367a9c57870cc70108b"
    
    private static func flickrURL(method: Method, parameters:[String:String]?) -> URL {
        
        let baseParameters = ["method": method.rawValue, "format":"json", "nojsoncallback":"1", "api_key": APIKey]
        var queryItems = [URLQueryItem]()
        for (key, value) in baseParameters{
            let queryItem = URLQueryItem(name: key, value: value)
            queryItems.append(queryItem)
        }
        if let additionalParameters = parameters{
            for (key,value) in additionalParameters {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
        }
        var components = URLComponents(string: baseURLString)
        components?.queryItems = queryItems
        return (components?.url)!
    }
    
    static func recentPhotosURL()->URL {
        return flickrURL(method: .RecentPhotos, parameters: ["extras":"url_h, date_taken"])
    }
    
    private static let dateFormattehr: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    private static func photoFromJSONObject(json: [String: AnyObject], context: NSManagedObjectContext) -> Photo? {
        guard
            let photoID = json["id"] as? String,
            let title = json["title"] as? String,
            let dateString = json["datetaken"] as? String,
            let photoURLString = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = dateFormattehr.date(from: dateString)
        else {
            return nil
        }
        
        //동일한 ID의 사진이 이미 있을 경우 저장하지 않고 CoreData에서 읽은것을 리턴한다.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        fetchRequest.predicate = NSPredicate(format:"photoID == \(photoID)")
        var fetchedPhotos: [Photo]!
        context.performAndWait(){
            fetchedPhotos = try! context.fetch(fetchRequest) as! [Photo]
        }
        if fetchedPhotos.count > 0 {
            return fetchedPhotos.first
        }
        
        //return Photo(title: title, remoteURL: url, photoID: photoID, dateTaken: dateTaken)
        var photo: Photo!
        context.performAndWait(){
            photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as! Photo
            photo.title = title
            photo.dateTaken = dateTaken
            photo.photoID = photoID
            photo.remoteURL = url
        }
        return photo
    }
    
    static func photosFromJSONData(data: Data, context:NSManagedObjectContext) -> PhotosResult{
        do{
            let jsonObject: AnyObject = try JSONSerialization.jsonObject(with: data, options: []) as! AnyObject
            guard
                let jsonDictionary = jsonObject as? [NSObject: AnyObject],
                let photos = jsonDictionary["photos" as NSString] as? [String: AnyObject],
                let photosArray = photos["photo"] as? [[String:AnyObject]] else {
                return .Failure(FlickrError.InvalidJSONData)
            }
            
            var finalPhotos = [Photo]()
            for photoJSON in photosArray {
                if let photo = photoFromJSONObject(json: photoJSON, context: context){
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return.Failure(FlickrError.InvalidJSONData)
            }
            
            return .Success(finalPhotos)
        }catch let error {
            return .Failure(error)
        }
    }
    
    static func imagesFromJSONData(data: Data, context:NSManagedObjectContext) -> ImageResult{
        do{
            let jsonObject: AnyObject = try JSONSerialization.jsonObject(with: data, options: []) as! AnyObject
            guard
                let jsonDictionary = jsonObject as? [NSObject: AnyObject],
                let photos = jsonDictionary["photos" as NSString] as? [String: AnyObject],
                let photosArray = photos["photo"] as? [[String:AnyObject]] else {
                return .Failure(FlickrError.InvalidJSONData)
            }
            
            var finalPhotos = [UIImage]()
            for photoJSON in photosArray {
                if let photo = photoFromJSONObject(json: photoJSON, context: context){
                    finalPhotos.append(photo.image!)
                }
            }
            
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return.Failure(FlickrError.InvalidJSONData)
            }
            
            return .Suceess2(finalPhotos)
        }catch let error {
            return .Failure(error)
        }
    }
}
