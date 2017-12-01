import Foundation
import Firebase
import FirebaseDatabase

class Post {
    private var _username: String!
    private var _userImg:String!
    private var _postImg: String!
    private var _likes: Int!
    private var _postKey: String!
    private var postRef: DatabaseReference!
    
    var username: String {
        return _username
    }
    
    var userImg: String {
        return _userImg
    }
    var postImg: String {
        get{
            return _postImg
        } set {
            _postImg = newValue
        }
    }
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
            return _postKey
    }
    init(imgUrl: String, likes: Int, username: String, userImg: String) {
        _likes = likes
        _postImg = imgUrl
        _userImg = userImg
        _username = username
        
    }
    
    init(postKey: String, postData:Dictionary<String, AnyObject>) {
        _postKey = postKey
        if let username = postData["username"] as? String {
            _username = username
        }
        if let userImg = postData["userImg"] as? String {
            _userImg = userImg
        }
        if let postImg = postData["imgUrl"] as? String {
            _postImg = postImg
        }
        if let likes = postData["likes"] as? Int {
            _likes = likes
        }
        postRef = Database.database().reference().child("posts")
        
    }
    
}

