//
//  ImageModel.swift
//  ImageCarouselApp
//
//  Created by Mahmood Al-haddad on 11/13/19.
//  Copyright © 2019 Mahmood Al-haddad. All rights reserved.
//

import Foundation

struct ImageModel {
    var imageUrl: String
    var items: [ItemModel] = []
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}
