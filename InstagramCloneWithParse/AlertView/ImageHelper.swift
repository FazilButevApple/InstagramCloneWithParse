//
//  ImageHelper.swift
//  InstagramCloneWithParse
//
//  Created by sys on 30.09.2022.
//

import Foundation
import UIKit

class ImageHelper
{
    class func loadImage(name: String?) -> UIImage? {
        guard let imageName = name else { return nil }
        
        let podBundle = Bundle(for: ImageHelper.self)
        guard let url = podBundle.url(forResource: "CDAlertView", withExtension: "bundle") else { return nil }
        
        let bundle = Bundle(url: url)
        return UIImage(named: imageName, in: bundle, compatibleWith: nil)
    }
}
