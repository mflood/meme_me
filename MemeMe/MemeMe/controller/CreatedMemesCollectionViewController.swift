//
//  CreatedMemesCollectionViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/21/23.
//


import UIKit

class CreatedMemesCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentEditMeme))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    @objc func presentEditMeme() {
        
        // Grab the DetailVC from Storyboard
        let editMemeViewController = self.storyboard!.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController

        // Present the view controller using navigation
        navigationController!.pushViewController(editMemeViewController, animated: true)
        
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        cell.theImage.image = meme.memedImage
       
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        detailController.meme = meme
        
        // detailController.villain = allVillains[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)

        return
    }
}


