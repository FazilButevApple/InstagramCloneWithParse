//
//  ExtensionHandler.swift
//  InstagramCloneWithParse
//
//  Created by sys on 4.10.2022.
//

import Foundation
import UIKit

class ExtensionHandler: UIViewController {
    
    static let shared = ExtensionHandler()
    
    func postLikeHeartAnimation(tapGesture:UITapGestureRecognizer) {
        
        let postLike = PostLikeExtension()
        
        postLike.didDoubleTap(tapGesture, title: "hello")
        
    }
}
