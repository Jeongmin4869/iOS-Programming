//
//  ViewController.swift
//  Photorama
//
//  Created by 이정민 on 2022/11/17.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet var collectionView = UICollectionView!
    var photoStore: PhotosStore!
    var photoDataSource: PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.dataSource = photoDataSource
        photoStore.fetchRecentPhotos(completion: { // 스레드에 의해 실행된다.
            (photosResult) -> Void in
            /*
            switch photosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) recent photos")
                if let firstPhoto = photos.first {
                    self.photoStore.fetchImageForPhoto(photo: firstPhoto){
                        (imageResult) -> Void in
                        switch imageResult{
                        case let .Success(image):
                            // self.imageView.image = image // 서브스레드 실행. 서브스레드는 UI를 건들수 없어 에러
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
             */
            OperationQueue.main.addOperation{
                switch photosResult{
                case let .Success(photos):
                    print("Successfully found \(photos.count) recent photos")
                    self.photoDataSource.photos = photos
                case let .Failure(error):
                    print("Error fetching recent photos: \(error)")
                    self.photoDataSource.photos.removeAll()
                }
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }) 
    }
}

