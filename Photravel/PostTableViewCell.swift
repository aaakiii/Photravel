import UIKit
import Firebase
import FirebaseStorage

class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    var post: Post!
    var userPostKey: FIRDatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(post: Post, img: UIImage? = nil, usrImg: UIImage? = nil) {
        self.post = post
        self.likeLabel.text = "\(post.likes)"
        self.username.text = post.username
        if userImg != nil{
            self.postImg.image = img
        } else {
            let ref = FIRStorage.storage().reference(forUrl: post.userImg)
            ref.data(withMaxSize: 2 * 1024, completion: {(data, error) in
                if error != nil{
                    print("couldn't load img")
                }else {
                    if let imgData = data{
                        if let img = UIImage(data: imgData){
                                self.postImg.imafe = img
                        }
                        
                    }
                    
                }
                
            })
        }
    }

}
