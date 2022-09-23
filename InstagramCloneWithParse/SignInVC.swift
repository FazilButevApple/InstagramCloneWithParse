//
//  SignInVC.swift
//  InstagramCloneWithParse
//
//  Created by sys on 19.09.2022.
//

import Foundation
import UIKit
import Parse

class SignInVC: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   /*     let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Apple"
        parseObject["price"] = "100"
        parseObject["color"] = "Yellow"
        parseObject.saveInBackground { (success,error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                print("Saved")
            }
        }
        
        let query = PFQuery(className: "Fruits")
        // query.whereKey("color", equalTo: "Yellow") rengi sarı olanları çeker sadece
        query.findObjectsInBackground { (data,error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                print("Veriler Çekildi \(data)")
            }
            
        } */
        
    }

    @IBAction func signInButton(_ sender: Any) {
        
        if usernameTF.text != "" && passwordTF.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameTF.text!, password: passwordTF.text!) { (user,error) in
                
                if error != nil {
                    self.makeAlert(errorTitle: "Error", errorMessage: error!.localizedDescription)
                }else {
                    // Beni Hatırla Kodları
                    UserDefaults.standard.set(self.usernameTF.text!, forKey: "username")
                    UserDefaults.standard.synchronize()
                    
                    let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
                    
                    sceneDelegate.rememberMe()
                }
            }
            
        } else {
            
            self.makeAlert(errorTitle: "Error", errorMessage: "Username / Password needed")
        }
 
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if usernameTF.text != "" && passwordTF.text != "" {
            
            let user = PFUser()
            user.username = usernameTF.text!
            user.password = passwordTF.text!
            
            user.signUpInBackground { (success,error) in
                if error != nil {
                    self.makeAlert(errorTitle: "Error", errorMessage: error!.localizedDescription)
                }else {
                    
                    // Beni Hatırla Kodları
                    UserDefaults.standard.set(self.usernameTF.text!, forKey: "username")
                    UserDefaults.standard.synchronize()
                    
                    let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
                    
                    sceneDelegate.rememberMe()
                    
                    
                }
            }
        } else {
            
            self.makeAlert(errorTitle: "Error", errorMessage: "Üye olurken hata ile karşılaşılmıştır.")
        }
 
        
        }
        
    
    
    func makeAlert(errorTitle : String , errorMessage : String) {
        
        let AlertVC = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        AlertVC.addAction(okButton)
        self.present(AlertVC, animated: true)
        
    }
}
