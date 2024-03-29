//
//  ViewController.swift
//  ImageCarouselApp
//
//  Created by Mahmood Al-haddad on 11/13/19.
//  Copyright © 2019 Mahmood Al-haddad. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageCarouselDelegate, SearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [ImageModel] = []
    var currentImage = 0
    var searchString = "" {
        didSet {
            self.setData()
            self.reloadData(onlyItems: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the nibs we are going to use in the collection view
        self.collectionView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageViewCell")
        self.collectionView.register(UINib(nibName: "CarouselViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselViewCell")
        self.collectionView.register(UINib(nibName: "ListItemViewCell", bundle: nil), forCellWithReuseIdentifier: "ListItemViewCell")
        self.collectionView.register(UINib(nibName: "SearchBarCell", bundle: nil), forCellWithReuseIdentifier: "SearchBarCell")
        
        // Attempt on sticky header
//        self.collectionView.register(UINib(nibName: "SearchBarView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBarView")
        
//        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
//        layout?.sectionHeadersPinToVisibleBounds = true
        
        self.setData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionView {
            // Parent collection view
            return 3
        } else {
            // Nested collection view
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            if section == 0 {
                // Slider section
                return 1
            } else if section == 1 {
                // Search bar section
                return 1
            } else {
                // Items section
                return data[currentImage].items.count
            }
            
        } else {
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselViewCell", for: indexPath) as! CarouselViewCell
                
                cell.collectionView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageViewCell")
                cell.delegate = self
                cell.pageControl.currentPage = currentImage
                cell.pageControl.numberOfPages = data.count
                
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.setup()
                return cell
            } else if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchBarCell", for: indexPath) as! SearchBarCell
                cell.delegate = self
                cell.setup()
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListItemViewCell", for: indexPath) as! ListItemViewCell
                let itemCount = indexPath.row
                cell.itemModel = data[currentImage].items[itemCount]
                cell.setup()
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
            
            let imageModel = data[indexPath.row]
            cell.imageModel = imageModel
            
            cell.setup()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == self.collectionView {
            if indexPath.section == 0 {
                return CGSize(width: self.view.frame.width, height: 250.0)
            } else {
                return CGSize(width: self.view.frame.width, height: 45.0)
            }

        } else {
            return CGSize(width: self.view.frame.width * 0.9, height: 250.0)
        }
    }

    // Attempt on sticky search bar
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind {
//
//        case UICollectionView.elementKindSectionHeader:
//            let headerSearchView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchBarView", for: indexPath) as! SearchBarView
//
//            headerSearchView.delegate = self
//            headerSearchView.searchBar.delegate = headerSearchView
//
//            return headerSearchView
//        default:
//            fatalError("This case is not handled")
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        if section == 1 {
//            return CGSize(width: self.view.frame.width, height: 45.0)
//        } else {
//            return CGSize.zero
//        }
//    }

    
    func setData() {
        // This is the data source
        // Everytime this function is called, i am resetting the data set for better diffing
        
        var newData: [ImageModel] = []
        var imageModel1 = ImageModel(imageUrl: "https://picsum.photos/seed/image1/500/700")
        
        var items: [ItemModel] = []
        for i in 0...18 {
            let itemModel = ItemModel(id: i, name: "Item \(i)", imageUrl: "https://picsum.photos/seed/item\(i)/200/300")
            items.append(itemModel)
        }
        
        if !searchString.isEmpty {
            items = items.filter({
                self.checkWithSearchString(string: $0.name)
            })
        }
        
        imageModel1.items = items
        
        newData.append(imageModel1)
        
        var imageModel2 = ImageModel(imageUrl: "https://picsum.photos/seed/image2/200/300")
        
        var items2: [ItemModel] = []
        for i in 0...3 {
            let itemModel = ItemModel(id: i, name: "Item \(i)", imageUrl: "https://picsum.photos/seed/item\(i)/200/300")
            items2.append(itemModel)
        }
        
        if !searchString.isEmpty {
            items2 = items2.filter({
                self.checkWithSearchString(string: $0.name)
            })
        }
        
        imageModel2.items = items2
        
        newData.append(imageModel2)
        
        self.data = newData
    }
    
    func imageChanged(index: Int) {
        // This is called when the slider image has been changed. Only update if the slider
        // went to another slide.
        
        if self.currentImage != index {
            self.currentImage = index
            self.reloadData()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView != self.collectionView {
            let index = Int(ceil(Double(scrollView.contentOffset.x) / Double(scrollView.frame.width * 0.9)))
            imageChanged(index: index)
        }
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView != self.collectionView {
            let index = Int(ceil(Double(scrollView.contentOffset.x) / Double(scrollView.frame.width * 0.9)))
            imageChanged(index: index)
        }
    }
    
    func searchTextChanged(text: String) {
        // This is called everytime the text in the search bar changes
        self.searchString = text
    }
    
    func checkWithSearchString(string: String) -> Bool {
        return string.lowercased().contains(self.searchString.lowercased())
    }
    
    func reloadData(onlyItems: Bool = false, oldData: [ItemModel]? = nil) {
        if onlyItems {
            self.collectionView.reloadSections([2])
            // Attempt on diffing
//            diffForSection(section: 1, oldData: oldData!, newData: self.data[currentImage].items)
        } else {
            self.collectionView.reloadData()
        }
    }
    
    // Attempt on diffing
    func diffForSection(section: Int, oldData: [ItemModel], newData: [ItemModel]) {
        
        var indexesToDelete: [IndexPath] = []
        var indexesToInsert: [IndexPath] = []
        
        var count = 0
        for _ in oldData {
            indexesToDelete.append(IndexPath(row: count, section: section))
            count += 1
        }
        
        var insertCount = 0
        for _ in newData {
            indexesToInsert.append(IndexPath(row: insertCount, section: section))
            insertCount += 1
        }
        
        
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: indexesToDelete)
            self.collectionView.insertItems(at: indexesToInsert)
        }, completion: { success in
            self.collectionView.reloadItems(inSection: 1)
        })
    }
    
}

