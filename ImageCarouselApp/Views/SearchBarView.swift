//
//  SearchBarView.swift
//  ImageCarouselApp
//
//  Created by Mahmood Al-haddad on 11/13/19.
//  Copyright © 2019 Mahmood Al-haddad. All rights reserved.
//

import UIKit

class SearchBarView: UICollectionReusableView, UISearchBarDelegate {
    
    var delegate: SearchBarDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.delegate?.searchTextChanged(text: self.searchBar.text!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.delegate?.searchTextChanged(text: self.searchBar.text!)
    }
}
