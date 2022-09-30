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
        //let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector())
        //usernameLbl.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        
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
