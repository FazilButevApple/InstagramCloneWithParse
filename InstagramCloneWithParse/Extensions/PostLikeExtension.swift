//
//  PostLikeExtension.swift
//  InstagramCloneWithParse
//
//  Created by sys on 4.10.2022.
//

import Foundation
import UIKit


class PostLikeExtension: UIViewController {
    
    @objc func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        
        guard let gestureView = gesture.view else {return}
        
        let size = gestureView.frame.size.width/4
        let heart = UIImageView(image: UIImage(systemName: "heart.fill"))
        heart.frame = CGRect(x: (gestureView.frame.size.width - size) / 2,
                             y: (gestureView.frame.size.height - size) / 2,
                             width: size,
                             height: size)
        heart.tintColor = .systemRed
        heart.alpha = 0
        
        gestureView.addSubview(heart)

            UIView.animate(withDuration: 0.5, animations: {
                
                heart.alpha = 1
                
            },completion: { done in
                if done {
                        UIView.animate(withDuration: 1, animations:  {
                            heart.alpha = 0
                        },completion: { done in
                            if done {
                                heart.removeFromSuperview()
                            }
                        })
                }
            })
        print("didDoubleTap active")
    }
}
