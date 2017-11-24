import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwardField: UITextField!
    
    var userUid: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func goToFeedVC(){
        performSegue(withIdentifier: "ToFeed", sender: nil)
    }
    func goToCreateUserVC(){
        performSegue(withIdentifier: "signup", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signup" {
            if let destination = segue.destination as? UserViewController{
                if userUid != nil{
                    destination.userUid = userUid
                }
                if emailField != nil {
                    destination.emailField = emailField.text
                }
                if passwardField != nil {
                    destination.passwardField = passwardField.text
                }
            }
        }
    }

    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let passward = passwardField.text {
            Auth.auth().signIn(withEmail: email, password: passward, completion:
                {(user, error) in
                    if error == nil {
                        if let user = user {
                            self.userUid = user.uid
                            self.goToFeedVC()
                        }
                    } else {
                        self.goToCreateUserVC()
                    }
            })
        }
    }
}

