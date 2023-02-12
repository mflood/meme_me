//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/11/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presentImagePicker(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    @IBAction func presentCamera(_ sender: Any) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func presentActivitycontroller(_ sender: Any) {

     
        let image = UIImage(named: "download",
                            in: Bundle(for: type(of:self)),
                            compatibleWith: nil)!
        
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // iPad is crashing without this...
        controller.popoverPresentationController?.sourceView = self.view
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func apresentActivitycontroller(_ sender: Any) {

        let image = UIImage()
        //let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //self.present(controller, animated: true, completion: nil)
        let imagePicker = UIImagePickerController()
        present(imagePicker, animated: true)
        
    }
    


}

