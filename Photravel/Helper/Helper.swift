import UIKit

class Helpers {
    // Crop images
    static func cropImage(image: UIImage, w: Int, h: Int) -> UIImage {
        // Resize
        let origRef    = image.cgImage
        let origWidth  = Int(origRef!.width)
        let origHeight = Int(origRef!.height)
        var resizeWidth:Int = 0
        var resizeHeight:Int = 0
        
        if (origWidth < origHeight) {
            resizeWidth = w
            resizeHeight = origHeight * resizeWidth / origWidth
        } else {
            resizeHeight = h
            resizeWidth = origWidth * resizeHeight / origHeight
        }
        
        let resizeSize = CGSize.init(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))
        UIGraphicsBeginImageContext(resizeSize)
        image.draw(in: CGRect.init(x: 0, y: 0, width: CGFloat(resizeWidth), height: CGFloat(resizeHeight)))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Crop from the center
        let cropRect  = CGRect.init(x: CGFloat((resizeWidth - w) / 2), y: CGFloat((resizeHeight - h) / 2), width: CGFloat(w), height: CGFloat(h))
        let cropRef   = resizeImage!.cgImage!.cropping(to: cropRect)
        let cropImage = UIImage(cgImage: cropRef!)
        
        return cropImage
    }
    
    // Corner radius
    static func addCornerRadius(imageView: UIImageView, radius: CGFloat) {
        imageView.layer.cornerRadius = radius
        imageView.clipsToBounds = true
    }
    
    // Get position Y: the Y value right under the above view
    static func getY(frame: CGRect) -> CGFloat {
        return frame.origin.y + frame.size.height
    }
}
