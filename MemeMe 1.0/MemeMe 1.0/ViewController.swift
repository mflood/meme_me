//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/11/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet var cameraButton: UIBarButtonItem? = nil
    @IBOutlet var cancelButton: UIBarButtonItem? = nil
    @IBOutlet var actionButton: UIBarButtonItem? = nil
    @IBOutlet var image: UIImageView? = nil
    @IBOutlet var topText: UITextField? = nil
    @IBOutlet var bottomText: UITextField? = nil
    // @IBOutlet var actionButton:
    
    func setupTextField(textfield: UITextField, initialText: String)
    {
        textfield.text = initialText
        textfield.textAlignment = .center
        textfield.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.actionButton?.isEnabled = false
        
        self.setupTextField(textfield: self.topText!, initialText: "TOP")
        self.setupTextField(textfield: self.bottomText!, initialText: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.cameraButton?.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }

    @IBAction func presentImagePicker(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @IBAction func presentCamera(_ sender: Any) {
        if(UIImagePickerController .isSourceTypeAvailable(.camera))
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
    
    @IBAction func handleCancel(_ sender: Any) {
        print("cancelled")
        self.resetView()
    }
    
    func resetView() {
        self.topText?.text = "TOP"
        self.bottomText?.text = "BOTTOM"
        self.image?.image = nil
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Finished picking")
        
        picker.dismiss(animated: true)
        
        self.actionButton?.isEnabled = true
        
    }
        
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        self.actionButton?.isEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // if textfield text is empty, should we reset TOP/BOTTOM
        // or leave it blank?
        
    }

}

