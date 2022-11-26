import UIKit

enum PhotosResult{
    case Success([Photo])
    case Failure(Swift.Error)
}

enum FlickrError: Swift.Error{
    case InvalidJSONData
}
