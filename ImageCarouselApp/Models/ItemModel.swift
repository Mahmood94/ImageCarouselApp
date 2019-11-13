//
//  ItemModel.swift
//  ImageCarouselApp
//
//  Created by Mahmood Al-haddad on 11/13/19.
//  Copyright © 2019 Mahmood Al-haddad. All rights reserved.
//

import Foundation

struct ItemModel {
    var name: String
    var imageUrl: String
    
    init(name: String, imageUrl: String) {
        self.name = name
        self.imageUrl = imageUrl
    }
}
