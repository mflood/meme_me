//
//  CreatedMemesCollectionViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/21/23.
//


import UIKit

class SentMemesCollectionViewController: UICollectionViewController, MemeCollectionChangeListener {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    func handleMemeCollectionChanged() {
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calculate size for collection items
        //
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 2.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        // configure the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(presentEditMeme))
        navigationItem.title = "Sent Memes"
        
    }

    @objc func presentEditMeme() {
        
        // Grab the EditMemeViewController from Storyboard
        let editMemeViewController = self.storyboard!.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController

        // By setting this, we will be notified if/when the meme collection changes
        editMemeViewController.memeCollectionChangeListener = self
        
        self.present(editMemeViewController, animated: true)
        
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


