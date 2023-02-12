//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presentImagePicker(_ sender: Any) {
        let viewController = UIImagePickerController()
        present(viewController, animated: true)
    }
    
    @IBAction func presentActivitycontroller(_ sender: Any) {

        let image = UIImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }

}

