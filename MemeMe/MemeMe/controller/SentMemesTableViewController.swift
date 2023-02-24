//
//  CreatedMemesTableViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/21/23.
//

import UIKit

class SentMemesTableViewController: UITableViewController, MemeCollectionChangeListener {
    
    func handleMemeCollectionChanged() {
        self.tableView.reloadData()
    }
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentEditMeme))
        navigationItem.title = "Sent Memes"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let skinnyside = min(view.frame.size.width, view.frame.size.height)
        self.tableView.rowHeight = skinnyside / 3.0
        
        self.tableView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let skinnyside = min(view.frame.size.width, view.frame.size.height)
        self.tableView.rowHeight = skinnyside / 3.0
    }
    
    
    @objc func presentEditMeme() {
        
        // Grab the DetailVC from Storyboard
        let editMemeViewController = self.storyboard!.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController

        // we will be notified if/when the meme collection changes
        editMemeViewController.memeCollectionChangeListener = self
        
        // Present the view controller using navigation
        self.present(editMemeViewController, animated: true)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell")!
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = "\(meme.topText) ... \(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
        
        
        
        // If the cell has a detail label, we will put the evil scheme in.
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = meme.bottomText
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        detailController.meme = meme
        
        // detailController.villain = allVillains[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)

        return
    }
}

