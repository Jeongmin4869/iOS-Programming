import UIKit

class Photo : Equatable{
    
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    var image: UIImage?
    
    init(title: String, remoteURL: URL, photoID: String, dateTaken: Date) {
        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
        self.dateTaken = dateTaken
    }
    
    static func == (lhs:Photo, rhs:Photo) -> Bool{
        return lhs.photoID == rhs.photoID
    }
    
}
