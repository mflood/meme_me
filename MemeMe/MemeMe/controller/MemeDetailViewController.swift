//
//  MemeDetailViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/21/23.
//


import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeImage: UIImageView!
    var meme: Meme? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meme = self.meme {
            self.memeImage.image = meme.memedImage
        }
     
    }
}

