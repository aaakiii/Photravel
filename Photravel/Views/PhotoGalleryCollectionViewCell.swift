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
        imageView.frame.origin.x = 0
        imageView.frame.origin.y = 0
        let url = URL(string: photo.imageByUrl)
        let data = try? Data(contentsOf: url!)
        imageView.image = UIImage(data: data!)
        imageView.sizeToFit()

    }

    // when the cell is getting reused.
    override func prepareForReuse() {
        self.imageView.image = nil
    }

}
