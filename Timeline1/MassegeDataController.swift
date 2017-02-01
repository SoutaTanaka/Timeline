import UIKit
import Firebase
import FirebaseDatabase
import JSQMessagesViewController
class MassegaViewController: UIViewController {
    @IBOutlet var authorLabel:UILabel!
    @IBOutlet var titlelabel:UILabel?
    var titles: String!
    var authors: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func post() {
        let myRootRef = FIRDatabase.database().reference()
        let postRef = myRootRef.child("posts")
        let post1 = ["author": "gracehop", "title": "Announcing COBOL, a New Programming Language"]
        postRef.setValue(post1)
        
        myRootRef.observe(.childAdded, with: { snapshot in
            var data = snapshot.value as! [String : Any]
            // data["author"] as! String
            self.authors = data["author"] as! String
            self.titles = data["title"] as! String
            
        })
    }
    
    
    @IBAction func a (){
        post()
        authorLabel.text = authors
        titlelabel?.text = titles
    }
}
