//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/11/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var cameraButton: UIBarButtonItem? = nil
    @IBOutlet var image: UIImage? = nil
    // @IBOutlet var actionButton:
    
    
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
    
    func getImage() -> UIImage {
        let image = UIImage(named: "download",
                            in: Bundle(for: type(of:self)),
                            compatibleWith: nil)!
        return image
    }
    
    @IBAction func presentActivitycontroller(_ sender: Any) {

        let image = self.getImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // iPad is crashing without this...
        controller.popoverPresentationController?.sourceView = self.view
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        
    }
        
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    


}

