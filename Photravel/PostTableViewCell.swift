import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    var post: Post!
    var userPostKey:DatabaseReference!
    let currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
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
            self.userImg.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.userImg)
            ref.getData(maxSize: 2 * 1024, completion: {(data, error) in
                if error != nil{
                    print("couldn't load img")
                }else {
                    if let imgData = data{
                        if let img = UIImage(data: imgData){
                                self.userImg.image = img
                        }
                        
                    }
                    
                }
                
            })
        }
    }

    @IBAction func liked(_ sender: AnyObject) {
        let likeRef = Database.database().reference().child("users").child(currentUser!).child("likes").child(post.postKey)
        likeRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.post.adjustLikes(addLike: true)
                likeRef.setValue(true)
            } else {
                self.post.adjustLikes(addLike: false)
                likeRef.removeValue()
            }
            
        })
        //
        
    }
}
