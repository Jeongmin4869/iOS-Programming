//
//  ViewController.swift
//  Photorama
//
//  Created by 이정민 on 2022/11/17.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView : UICollectionView!
    var photoStore: PhotosStore!
    var photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        photoStore.fetchImageForPhoto(photo: photo){
            (result) -> Void in
            
            OperationQueue.main.addOperation{
                switch result{
                    case let .Success(image):
                        photo.image = image
                    case let .Failure(error):
                        photo.image = nil
                }
                OperationQueue.main.addOperation{
                    let photoIndex = self.photoDataSource.photos.index(of: photo)
                    let photoIndexPath = IndexPath(item: photoIndex!, section: 0)
                    
                    if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell{
                        cell.updateWithImage(image: photo.image)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto" {
            // 여러개가 선택된 경우 첫번째 것을 선택한다.
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first{
                let photo = photoDataSource.photos[selectedIndexPath.row]
                let destination = segue.destination as! PhotoInfoViewController
                destination.photoStore = photoStore
                destination.photo = photo
            }
        }
    }
}

