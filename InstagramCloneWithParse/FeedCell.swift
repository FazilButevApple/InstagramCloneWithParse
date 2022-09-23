//
//  FeedCell.swift
//  InstagramCloneWithParse
//
//  Created by sys on 23.09.2022.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var usernameLbl: UILabel!
    
    @IBOutlet weak var userUUIDLbl: UILabel!
    
    @IBOutlet weak var commentLbl: UILabel!
    
    @IBOutlet var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userUUIDLbl.isHidden = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
    }
    
    
    @IBAction func commentButtonClicked(_ sender: Any) {
    }
    
}
