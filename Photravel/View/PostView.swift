import UIKit

class PostView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }

}
