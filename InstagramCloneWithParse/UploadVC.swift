//
//  SecondViewController.swift
//  InstagramCloneWithParse
//
//  Created by sys on 19.09.2022.
//

import Foundation
import UIKit
import Parse

class UploadVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    let signindelegate = SignInVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)
        
        postImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        postImage.addGestureRecognizer(gestureRecognizer)
        
        shareButton.isEnabled = false
    }
    
    @objc func hideKeyboard() {
        
        self.view.endEditing(true)
    }
    
    @objc func choosePhoto() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        shareButton.isEnabled = true
    }

    @IBAction func shareButtonClicked(_ sender: Any) {
        shareButton.isEnabled = false
 
        let object = PFObject(className: "Posts")
        
        let data = postImage.image?.jpegData(compressionQuality: 0.5)
        let PFImage = PFFileObject(name: "image", data: data!)
        
        let uuid = UUID().uuidString
        let uuidPost = "\(uuid) \(PFUser.current()?.username!)"
        
        object["postUUID"] = uuidPost
        object["postImage"] = PFImage
        object["postComment"] = commentTF.text
        object["postOwner"] = PFUser.current()!.username!
        //object["postOwner"] = UserDefaults.standard.value(forKey: "username") yukarıdaki satır yerine kullanılabilir.
        
        
        object.saveInBackground { (success,error) in
                
            if error != nil {
                
                self.signindelegate.makeAlert(errorTitle: "Error", errorMessage: error!.localizedDescription)
                
            }else {
                self.commentTF.text = ""
                self.postImage.image = UIImage(named:"select_image")
                self.tabBarController?.selectedIndex = 0
                
            }
        }
    }
    
}
