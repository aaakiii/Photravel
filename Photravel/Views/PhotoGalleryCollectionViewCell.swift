import UIKit

class PhotoGalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    func setImage(photo: Photo){
        // set image
        imageView.image = UIImage(named: "sample")
        imageView.sizeToFit()
        
    }

}
