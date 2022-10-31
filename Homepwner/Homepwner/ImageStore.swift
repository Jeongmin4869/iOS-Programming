//
//  ImageStore.swift
//  Homepwner
//
//  Created by 이정민 on 2022/10/25.
//

import Foundation
import UIKit

class ImageStore: NSObject{
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    //itemKey를 파일 이름으로 하는 URL 생성함수
    func imageURLForKey(key: String) -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(key)
    }
    
    func setImage(image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as AnyObject)
        let imageURL = imageURLForKey(key: key)
        if let data = image.jpegData(compressionQuality: 0.5){
            do{
                try data.write(to: imageURL)
            }catch{
                print("Error: writing image to a file")
            }
        }
    }
    
    
    func imageForKey(key: String) -> UIImage?{
        //return cache.object(forKey: key as AnyObject) as? UIImage
        if let existingImage = cache.object(forKey: key as AnyObject) as? UIImage{
            return existingImage
        }
        
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile:  imageURL.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as AnyObject)
        return imageFromDisk
         
    }
    
    func deleteImage(key: String){
        cache.removeObject(forKey: key as AnyObject)
    }
    
}

