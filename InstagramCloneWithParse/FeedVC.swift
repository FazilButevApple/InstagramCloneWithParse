//
//  ViewController.swift
//  InstagramCloneWithParse
//
//  Created by sys on 19.09.2022.
//

import UIKit
import Parse

class FeedVC: UIViewController {

    let signindelegate = SignInVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logoutClicked(_ sender: Any) {
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

