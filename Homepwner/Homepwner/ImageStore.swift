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
    
    func setImage(image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as AnyObject)
    }
    
    
    func imageForKey(key: String) -> UIImage?{
        return cache.object(forKey: key as AnyObject) as? UIImage
    }
    
    func deleteImage(key: String){
        cache.removeObject(forKey: key as AnyObject)
    }
    
}

