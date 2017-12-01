import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class UserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userImagePickr: UIImageView!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    
    var userUid: String!
    var emailField: String!
    var passwardField: String!
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

    }
    
    func keychain(){
        KeychainWrapper.standard.set(userUid, forKey: "uid")
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            userImagePickr.image = image
            imageSelected = true
        }else {
            print("image isn't selected")
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func setupUser(img: String) {
        let userData = [
            "username":  username,
            "userimage": img
        ]
        keychain()
        let setLocation = Database.database().reference().child("users").child(userUid)
        setLocation.setValue(userData)
    }
    
    func uploadImage(){
        if usernameField.text == nil {
            print("put user name")
            completeButton.isEnabled = false
        }else {
            completeButton.isEnabled = true
            username = usernameField.text
        }
        guard let img = userImagePickr.image, imageSelected == true else{
            print("choose image")
            return
        }
        
        if let  imageData = UIImageJPEGRepresentation(img, 0.2){
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "img/jpg"
            Storage.storage().reference().child(imgUid).putData(imageData, metadata: metadata) {
                (metadata, error) in
                if error != nil {
                    print("didn't upload img")
                } else {
                    print("img uploaded")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.setupUser(img: url)
                    }
                }
            }
        }
    }
    
    @IBAction func completeAccount(_ sender: Any){
        Auth.auth().createUser(withEmail: emailField, password: passwardField, completion:{(user,error) in
            if error != nil {
                print(error)
            } else {
                if let user = user {
                    self.userUid =  user.uid
                }
            }
            self.uploadImage()
        } )
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectedImagePicker(_ sender: Any){
        present(imagePicker, animated: true, completion: nil)
    }
    
    //  cancel button 作ったら
//    @IBAction func cancel(_ sender: Any){
//        dismiss(animated: true, completion: nil)
//    }
   

}
