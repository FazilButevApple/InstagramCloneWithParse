//
//  ViewController.swift
//  InstagramCloneWithParse
//
//  Created by sys on 19.09.2022.
//

import UIKit
import Parse

class FeedVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUUIDArray = [String]()
    var postImageArray = [PFFileObject]()
    let signindelegate = SignInVC()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return postOwnerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for:indexPath) as! FeedCell
        
        cell.usernameLbl.text = postOwnerArray[indexPath.row]
        cell.commentLbl.text = postCommentArray[indexPath.row]
        cell.userUUIDLbl.text = postUUIDArray[indexPath.row]
        
        postImageArray[indexPath.row].getDataInBackground { (data,error) in
            if error != nil {
                
                self.signindelegate.makeAlert(errorTitle: "getData Image Error", errorMessage: error!.localizedDescription)
                
            }else {
                
                cell.postImage.image = UIImage(data: data!)
                
            }
            
            
        }
        
        return cell
    }
    

    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newPost"), object: nil)
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
    
    
    @objc func getData() {
        
        let query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects,error) in
            
            if error != nil {
                self.signindelegate.makeAlert(errorTitle: "getData Error", errorMessage: error!.localizedDescription)
                
            }else {
                
                self.postOwnerArray.removeAll()
                self.postImageArray.removeAll()
                self.postCommentArray.removeAll()
                self.postUUIDArray.removeAll()
                
                if objects!.count > 0 {
                    for object in objects! {
                        
                        self.postOwnerArray.append(object.object(forKey: "postOwner") as! String)
                        self.postCommentArray.append(object.object(forKey: "postComment") as! String)
                        self.postUUIDArray.append(object.object(forKey: "postUUID") as! String)
                        self.postImageArray.append(object.object(forKey: "postImage") as! PFFileObject)
                        
                    }
                    
                }
                self.tableView.reloadData()
            }
            
            
            
        }
        
        
    }
    
}

