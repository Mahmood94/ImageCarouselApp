//
//  File.swift
//  ImageCarouselApp
//
//  Created by Mahmood Al-haddad on 11/13/19.
//  Copyright © 2019 Mahmood Al-haddad. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(fromUrl: String) {
        
        let url = NSURL(string: fromUrl)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            self.image = UIImage(data: imageData as Data)
        }
    }
}
