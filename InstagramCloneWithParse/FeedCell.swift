//
//  FeedCell.swift
//  InstagramCloneWithParse
//
//  Created by sys on 23.09.2022.
//

import UIKit
import Parse

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var userUUIDLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet var postImage: UIImageView!
    let signindelegate = SignInVC()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userUUIDLbl.isHidden = true
        
        usernameLbl.isUserInteractionEnabled = true
        postImage.isUserInteractionEnabled = true
        postImage.clipsToBounds = true
        //let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector())
        //usernameLbl.addGestureRecognizer(gestureRecognizer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        tapGesture.numberOfTapsRequired = 2
        postImage.addGestureRecognizer(tapGesture)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    @objc func doubleTap(_ TapGesture: UITapGestureRecognizer) {
        ExtensionHandler.shared.postLikeHeartAnimation(tapGesture: TapGesture)
    }


    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let alert = CDAlertView(title: "Awesome Title", message: "Are you in?!", type: .error)
        let doneAction = CDAlertViewAction(title: "Sure! 💪")
        alert.add(action: doneAction)
        let nevermindAction = CDAlertViewAction(title: "Nevermind 😑")
        alert.add(action: nevermindAction)
        //alert.isTextFieldHidden = false
        alert.show()
        
        let likeObject = PFObject(className: "Likes")
        
        let uuid = UUID().uuidString
        let postUUID = "\(uuid) \(PFUser.current()!.username!)"
        
        likeObject["postUUID"] = postUUID
        likeObject["likeFrom"] = PFUser.current()!.username!
        likeObject["likeTo"] = userUUIDLbl.text
        
        likeObject.saveInBackground { (success,error) in
            
            if error != nil {
                self.signindelegate.makeAlert(errorTitle: "Like Save Error", errorMessage: error!.localizedDescription)
            }else {
                print("Like Button Pressed")
                print("Like Saved")
            }
            
        }
    }
    
    
    @IBAction func commentButtonClicked(_ sender: Any) {
        
        let commentObject = PFObject(className: "Comments")
        
        let uuid = UUID().uuidString
        let postUUID = "\(uuid) \(PFUser.current()!.username!)"
        
        commentObject["postUUID"] = postUUID
        commentObject["commentFrom"] = PFUser.current()!.username!
        commentObject["commentTo"] = userUUIDLbl.text
        
        commentObject.saveInBackground { (success,error) in
            
            if error != nil {
                self.signindelegate.makeAlert(errorTitle: "Comment Save Error", errorMessage: error!.localizedDescription)
            }else {
                
                print("Comment Saved")
            }
            
        }
        
    }
    
}
