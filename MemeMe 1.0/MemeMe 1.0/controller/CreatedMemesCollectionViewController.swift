//
//  CreatedMemesCollectionViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/21/23.
//


import UIKit

class CreatedMemesCollectionViewController: UICollectionViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        cell.theImage.image = UIImage(named: "test")
        cell.theLabel.text = "hi"
            // let villain = self.allVillains[(indexPath as NSIndexPath).row]



            return cell
        
    }
}


