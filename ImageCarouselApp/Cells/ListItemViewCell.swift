//
//  ListItemViewCell.swift
//  ImageCarouselApp
//
//  Created by Mahmood Al-haddad on 11/13/19.
//  Copyright © 2019 Mahmood Al-haddad. All rights reserved.
//

import UIKit

class ListItemViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var itemModel: ItemModel?
    
    func setup() {
        if let itemModel = itemModel {
            self.label.text = itemModel.name
            imageView.loadImage(fromUrl: itemModel.imageUrl)
        }
    }
}
