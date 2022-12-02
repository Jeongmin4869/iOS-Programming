import UIKit

class PhotoCollectionViewCell : UICollectionViewCell{
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func updateWithImage(image: UIImage?){
        if let imageToDisplay = image{
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        }else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    //로딩되면 호출
    override func awakeFromNib() {
        super.awakeFromNib()
        updateWithImage(image: nil)
    }
    //재사용되기 직전에 호출
    override func prepareForReuse() {
        super.prepareForReuse()
        updateWithImage(image: nil)
    }
}
