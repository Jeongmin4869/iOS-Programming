//
//  FlickrAPI.swift
//  Photorama
//
//  Created by 이정민 on 2022/11/17.
//

import Foundation
import UIKit

enum Method: String{
    case RecentPhotos = "flickr.photos.getRecent"
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
    private static func photoFromJSONObject(json: [String: AnyObject]) -> Photo? {
        guard
            let photoID = json["id"] as? String,
            let title = json["title"] as? String,
            let dateString = json["dateTaken"] as? String,
            let photoURLString = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = dateFormattehr.date(from: dateString)
        else {
            return nil
        }
        return Photo(title: title, remoteURL: url, photoID: photoID, dateTaken: dateTaken)a
    }
}
