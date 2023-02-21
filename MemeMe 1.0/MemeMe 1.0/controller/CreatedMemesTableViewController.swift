//
//  CreatedMemesTableViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/21/23.
//

import UIKit

class CreatedMemesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell")!
        
        // let villain = self.allVillains[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = "my text"
        cell.imageView?.image = UIImage(named: "test")
        
        // If the cell has a detail label, we will put the evil scheme in.
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = "more info"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        let testImage = UIImage(named: "test")!
        
        detailController.meme = Meme(topText: "this be top", bottomText: "this be vottom", originalImage: testImage, memedImage: testImage)
        
        //let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! VillainDetailViewController
        
        // detailController.villain = allVillains[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)

        return
    }
}

