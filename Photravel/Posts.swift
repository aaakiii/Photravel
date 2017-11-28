import Foundation
import Firebase

class Post {
    private var username: String!
    private var userImg:String!
    private var postImg: String!
    private var likes: Int!
    private var postKey: String!
    private var postRef: FIRDatabaseReference
    
    var username: String {
        return username
    }
    
    var userImg: String {
        return userImg
    }
    var postImg: String {
        get{
            return postImg
        } set {
            postImg = newValue
        }
    }
    var likes: Int {
        return likes
    }
    
    var postKey: String {
            return postKey
    }
    init(imgUrl: String, likes: Int, username: String, userImg: String) {
        likes = likes
        postImg = imgUrl
        userImg = userImg
        username = username
        
    }
    
    init(postKey: String, postData:Dictionary<String, AnyObject>) {
        postKey = postKey
        if let username = postData["username"] as? String {
            username = username
        }
        if let userImg = postData["userImg"] as? String {
            userImg = userImg
        }
        if let postImg = postData["imgUrl"] as? String {
            postImg = postImg
        }
        if let likes = postData["likes"] as? Int {
            likes = likes
        }
        postRef = FIRDatabase.database().reference().child["posts"]
        
    }
    
}

