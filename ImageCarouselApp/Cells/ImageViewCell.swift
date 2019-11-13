//
//  ImageCellView.swift
//  ImageCarouselApp
//
//  Created by Mahmood Al-haddad on 11/13/19.
//  Copyright © 2019 Mahmood Al-haddad. All rights reserved.
//

import UIKit


class ImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageModel: ImageModel?
    
    func setup() {
        if let imageModel = imageModel {
            imageView.loadImage(fromUrl: imageModel.imageUrl)
        }
        
    }
}
