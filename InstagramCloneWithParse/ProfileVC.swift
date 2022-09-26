//
//  ProfileVC.swift
//  InstagramCloneWithParse
//
//  Created by sys on 26.09.2022.
//

import UIKit
import Parse

class ProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profileExplainLbl: UILabel!
    let signindelegate = SignInVC()
    let profileImageArray = [PFFileObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        profileImage.image = UIImage(named: "empty_profil_image")
        
        usernameLbl.text = PFUser.current()!.username!
        profileExplainLbl.text = "Drummer"
        
        let query = PFQuery(className: "ProfilePhotos")
        query.whereKey("Username", equalTo: PFUser.current()!.username!)
        query.addAscendingOrder("createdAt")
        query.findObjectsInBackground { (objects,error) in
            if error != nil {
                self.signindelegate.makeAlert(errorTitle: "getProfilePhoto Error", errorMessage: error!.localizedDescription)
            }else {
                for object in objects! {
                    let imageFiles = object["ProfilePhoto"] as! PFFileObject
                    imageFiles.getDataInBackground { (data,error) in
                        if error != nil {
                            
                            self.signindelegate.makeAlert(errorTitle: "getData Image Error", errorMessage: error!.localizedDescription)
                            
                        }else {
                            self.profileImage.image = UIImage(data: data!)
                            
                        }
                    }
                }
            }
        }
        
        profileImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseProfilePhoto))
        profileImage.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
    }
    
    
    @objc func chooseProfilePhoto() {
        
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            pickerController.allowsEditing = true
            present(pickerController, animated: true)
            
        
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImage.image = info[.originalImage] as? UIImage
        
        let object = PFObject(className: "ProfilePhotos")
        
        let data = profileImage.image?.jpegData(compressionQuality: 0.5) /// data isminde bir değişkende galeriden seçilen image'ı %50 oranında küçültüp kaydediyoruz.
        let PFImage = PFFileObject(name: "image", data: data!) /// data içindeki resimin PFFileObject ile saklanması
        
        object["Username"] = PFUser.current()?.username
        object["ProfilePhoto"] = PFImage
        
        object.saveInBackground { (success , error) in
            
            if error != nil {
                
                self.signindelegate.makeAlert(errorTitle: "ProfilePhoto Saved Error", errorMessage: error!.localizedDescription)
                
            }else {
                
                print("Profile Photo Saved Success!")
                
            }
            
            
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            
            if error != nil {
                self.signindelegate.makeAlert(errorTitle: "Error", errorMessage: "Çıkış yapılırken hata ile karşılaşıldı.")
            }else {
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
                
                let signinVC = self.storyboard?.instantiateViewController(withIdentifier: "signIn")
                
                let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
                sceneDelegate.window!.rootViewController = signinVC
                sceneDelegate.rememberMe()
                
                
            }
        }
    }
    

}
