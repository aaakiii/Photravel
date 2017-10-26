import UIKit

class PhotoGalleryCollectionViewCell: UICollectionViewCell {

    var photo: Photo?
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    func setImage(photo: Photo){
        self.photo = photo

        // Photo image view
        let screenWidth = UIScreen.main.bounds.size.width
        imageView.frame.origin.x = 10
        imageView.frame.origin.y = 10
        let url = URL(string: photo.imageByUrl)
        let data = try? Data(contentsOf: url!)
        imageView.image = Helpers.cropImage(image: UIImage(data: data!)!, w: Int(screenWidth - 40), h: Int(screenWidth - 40))
        imageView.sizeToFit()
        
    }

}
