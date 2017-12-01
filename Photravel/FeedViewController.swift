import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    var posts = [Post]()
    var post: Post!
    var imgPicker: UIImagePickerController!
    var imageSelected = false
    var selectedImg: UIImage!
    var userImg: String!
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        
        Database.database().reference().child("posts").observe(.value, with:
            {(snapshot) in
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    
                    self.posts.removeAll()
                    for data in snapshot {
                        print(data)
                        if let postDictionary = data.value as? Dictionary<String, AnyObject> {
                            let key = data.key
                            let post = Post(postKey: key, postData: postDictionary)
                            self.posts.append(post)
                        }
                    }
                    
                }
                self.tableView.reloadData()
        })

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PostTableViewCell {
            cell.configCell(post: post)
            return cell
        } else {
            return PostTableViewCell()
        }
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerController] as? UIImage {
            selectedImg = image
            imageSelected = true
        } else {
            print("valid image wasn't selected")
        }
        imgPicker.dismiss(animated: true, completion: nil)
        
        guard imageSelected == true  else {
            print("image needs to be selected")
            return
        }
        if let imgData = UIImageJPEGRepresentation(selectedImg, 0.2) {
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            Storage.storage().reference().child("post-pics").child(imgUid).putData(imgData, metadata: metadata) {(metadata, error) in
                if error != nil {
                    print("image wasn't saved")
                } else {
                    print("image was saved")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.PostToFirbase(imgUrl: url)
                    }
                }
            }
        }
        
    }
    
    func PostToFirbase(imgUrl: String) {
        let userId = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as! Dictionary<String, AnyObject>
            let username = data["username"]
            let userImg = data["userImg"]
            let post: Dictionary<String, AnyObject> = [
                "username" = username!,
                "userImg" = userImg!,
                "imageUrl" = imgUrl as AnyObject,
                "likes" = 0 as AnyObject
            ]
            let firebasePost = Database.database().reference().child("posts").childByAutoId()
            firebasePost.setValue(post)
            self.imageSelected = false
            self.tableView.reloadData()
            
        })
    }
    
    @IBAction func postImageTapped(_ sender: AnyObject) {
        present(imgPicker, animated: true, completion: nil)
        
    }
    
    @IBAction func Signout(_ sender: AnyObject) {
        try! Auth.auth().signOut()
        
        KeychainWrapper.standard.removeObject(forKey: "uid")
        dismiss(animated: true, completion: nil)
    }
    
}
