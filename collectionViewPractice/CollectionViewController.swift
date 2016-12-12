//
//  CollectionViewController.swift
//  collectionViewPractice
//
//  Created by modelf on 12/8/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import UIKit



class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var layout: UICollectionViewLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        
        
        let width = floor(self.collectionView.frame.size.width/3 - 3)
        let height = floor(self.collectionView.frame.size.height / 3)
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }()
    
    lazy var layoutMaximized: UICollectionViewLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        let width = floor(self.collectionView.frame.size.width)
        let height = floor(self.collectionView.frame.size.height)
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
}

extension CollectionViewController: UICollectionViewDataSource {

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

        return 18
        
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        collectionView.collectionViewLayout = layout

 
        print("Data source method firing")
        cell.backgroundColor = .purple
        
        
        // Configure the cell
    
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    enum Status {
        case minimized, selected, maximized
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        let imageToEdit = collectionView.cellForItem(at: indexPath)

        
        UIView.animate(withDuration: 0.4) {
            
            var viewToCover = UIView()

            let horizontalConstraint = NSLayoutConstraint(item: viewToCover, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.collectionView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: viewToCover, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.collectionView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: viewToCover, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100)
            let heightConstraint = NSLayoutConstraint(item: viewToCover, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100)

            viewToCover.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
            self.view.addSubview(viewToCover)
        }
    }
    
}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

// trys on the backburner 
// - adjusting layouts
//    let imageToEdit = collectionView.cellForItem(at: indexPath)
//    
//    var timesTapped = 0
//    var incrementvalue = 1
//    
//    timesTapped += incrementvalue
//    print("times tapped : \(timesTapped)")
//    
//    if timesTapped == 0 {
//    
//    incrementvalue = 1
//    collectionView.collectionViewLayout = layoutMaximized
//    print("\(timesTapped)")
//    }
//    if timesTapped == 3 {
//    timesTapped = 0
//    collectionView.collectionViewLayout = layout
//    }


