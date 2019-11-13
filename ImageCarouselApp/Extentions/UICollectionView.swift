//
//  UICollectionView.swift
//  ImageCarouselApp
//
//  Created by Mahmood Al-haddad on 11/13/19.
//  Copyright © 2019 Mahmood Al-haddad. All rights reserved.
//

import UIKit

extension UICollectionView {
    func reloadItems(inSection section: Int) {
        reloadItems(at: (0..<numberOfItems(inSection: section)).map {
            IndexPath(item: $0, section: section)
        })
    }
}
