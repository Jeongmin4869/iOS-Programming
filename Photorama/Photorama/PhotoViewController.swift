//
//  ViewController.swift
//  Photorama
//
//  Created by 이정민 on 2022/11/17.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var photoStore: PhotosStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoStore.fetchRecentPhotos(completion: { // 스레드에 의해 실행된다.
            (photosResult) -> Void in
            switch photosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) recent photos")
                if let firstPhoto = photos.first {
                    self.photoStore.fetchImageForPhoto(photo: firstPhoto){
                        (imageResult) -> Void in
                        switch imageResult{
                        case let .Success(image):
                            // self.imageView.image = image
                            OperationQueue.main.addOperation{ // 메인 스레드에의해 실행되는 부분. 
                                self.imageView.image = image
                            }
                        case let .Failure(error):
                            print("Error downloading image : \(error)")
                        }
                    }
                }
            case let .Failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }) 
    }
}

