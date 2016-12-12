//
//  CollectionViewController.swift
//  collectionViewPractice
//
//  Created by Christopher Moore on 12/8/16.
//  Copyright © 2016 Christopher Moore. All rights reserved.
//

import UIKit

/* This is inteded to be used as a template for a collectionView that needs to have the ability to resize an image based on a user click, and then listen for another click to change back to the original. I was having a hell of a time finding something simple and easy to understand so I made it myself.
 
    Other options to explore -> 
        - creating custom segues
        - manually adding and removing a subclass of UIView (would need to have other gesture recognizers for swipe left and right to change pictures)

*/


class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // This will be the layout that uses flow line-breaking default to display a grid of items for our view. The sizing works for my iPhone 5c but needs to be tested for others (should work).
    lazy var verticleScrollLayout: UICollectionViewLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        
        
        let width = floor(self.collectionView.frame.size.width/3 - 3)
        let height = floor(self.collectionView.frame.size.height / 3)
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }()
    
    // Maximize the image and allow horizonal scrolling for easier to see pictures. For some cases you might want to adjust the .contentMode to fix image stretching.
    
    
    lazy var horizontalScrollLayout: UICollectionViewLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        let width = floor(self.collectionView.frame.size.width - 8)
        let height = floor(self.collectionView.frame.size.height - 8)
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }()
    
    // Set our manditory dataSource source and our optional delegate (which we will be using for when the user selects an item in the collectionView).
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    // Setting the initial layout in viewDidLoad causes issues. We also can't set it in our delegates because it will resize every time the delegate is fired, so we do it once during initial setup.
    
    override func viewDidLayoutSubviews() {

        collectionView.collectionViewLayout = verticleScrollLayout
    }
    
    // Selector message that will resize to a horizontal scroll. We remove the gesture recognizer after the view layout has changed so we can listen for the delegate method to fire (when we will want to resize back to our normal view again).
    
    func resizeLayoutForHorizontalScroll(_ sender: UIGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            self.collectionView.collectionViewLayout = self.verticleScrollLayout
            self.collectionView.removeGestureRecognizer(sender)
        }
    }
}
// DataSource manditory methods for collectionView -- these are not optional and must be implimented
extension CollectionViewController: UICollectionViewDataSource {

    // I'm returning 18 to simply and quickly fill the grid with a static number of items.
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 18
        
    }
    
    // Create a simple cell.
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

 
        print("Data source method firing")
        // just used to create contrast
        cell.backgroundColor = .purple
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    // The delgate method will fire every time the user taps a rectangle in the collectionView

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        // create and add the gesture regonizer, set the selector to our function for resizing layout
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CollectionViewController.resizeLayoutForHorizontalScroll(_:)))
        collectionView.addGestureRecognizer(tap)
        
        // create a simple animation to change the layout here.
        UIView.animate(withDuration: 0.5) {
            collectionView.collectionViewLayout = self.horizontalScrollLayout
        }
        
        print("selected delegate firing")
        
    }
}
