import UIKit
import Firebase
import FirebaseDatabase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postButton: UIButton!
    
    var posts = [Post]()
    var post: Post!
    var imgPicker: UIImagePickerController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        
        Database.database().reference().child("posts").observe(.value, with:
            {(snapshot) in
                if let snapshot = snapshot.children.allobjects as? [DataSnapshot] {
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
            return PostTableViewCell[]
        }
        
    }
}
