import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var photoStore: PhotosStore!
    var photo: Photo!{
        didSet{
            navigationItem.title = photo.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoStore.fetchImageForPhoto(photo: photo){
            (imageResult) -> Void in
            switch imageResult {
            case let .Success(imagee):
                OperationQueue.main.addOperation{
                    self.imageView.image = imagee
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
}
