//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Matthew Flood on 2/11/23.
//

import UIKit

let debug: Bool = false

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
}


class ViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet var cameraButton: UIBarButtonItem? = nil
    @IBOutlet var cancelButton: UIBarButtonItem? = nil
    @IBOutlet var actionButton: UIBarButtonItem? = nil
    @IBOutlet var image: UIImageView? = nil
    @IBOutlet var topText: UITextField? = nil
    @IBOutlet var bottomText: UITextField? = nil
    
    @IBOutlet var toolbar: UIToolbar? = nil
    @IBOutlet var navBar: UINavigationBar? = nil
    
    var isEditingBottomTextfield: Bool = false
    
    // @IBOutlet var actionButton:
    
    // MARK: - Setup and Teardown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.actionButton?.isEnabled = false
        
        self.setupTextField(textfield: self.topText!, initialText: "TOP")
        self.setupTextField(textfield: self.bottomText!, initialText: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        self.cameraButton?.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setupTextField(textfield: UITextField, initialText: String)
    {
        textfield.delegate = self
                
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.strokeColor: UIColor.black,
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                    NSAttributedString.Key.strokeWidth:  -6.0
                ]
                
        textfield.defaultTextAttributes = memeTextAttributes
                
        // This stuff needs to happen after defaultTextAttributes are set!
        // or they get reset to defaults...
        textfield.textAlignment = .center
            
        textfield.text = initialText
        
        if debug {
            // so we can see button
            textfield.backgroundColor = .yellow
        }
    }
    
    
    // MARK: - Text Fields
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        if textField == self.bottomText {
            isEditingBottomTextfield = true
        } else {
            isEditingBottomTextfield = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // if textfield text is empty, should we reset TOP/BOTTOM
        // or leave it blank?
    }

    
    // MARK: - Keyboard adjusts view position
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        guard self.isEditingBottomTextfield else {
            return
        }
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: - Image picker and Camera
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Finished picking")
        
        picker.dismiss(animated: true)
        
        self.actionButton?.isEnabled = true
        
        let key = UIImagePickerController.InfoKey.originalImage
        if let userImage =  info[key] as? UIImage {
            self.image?.image = userImage
        }
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        self.actionButton?.isEnabled = false
    }
    
    
    // MARK: - Meme sharing
    
    @IBAction func presentActivitycontroller(_ sender: Any) {

        let image = self.getImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // iPad is crashing without this...
        controller.popoverPresentationController?.sourceView = self.view
        controller.completionWithItemsHandler = {
            (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                print("Share completed")
                self.save(memedImage: image)
                return
            } else {
                print("cancelled")
            }
        }
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func save(memedImage: UIImage) {
        // Create the meme
        let meme = Meme(topText: self.topText!.text!,
                        bottomText: self.bottomText!.text!,
                        originalImage: self.image!.image!,
                        memedImage: memedImage)
    }
    
    func getImage() -> UIImage {
        
        return generateMemedImage()
        
        /*let image = UIImage(named: "download",
                            in: Bundle(for: type(of:self)),
                            compatibleWith: nil)!
        return image */
    }
    
    func generateMemedImage() -> UIImage {

        // TODO: Hide toolbar and navbar
        self.toolbar?.isHidden = true
        self.navBar?.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        // UIGraphicsBeginImageContext(self.image!.frame.size)
        // UIGraphicsBeginImageContext(<#T##size: CGSize##CGSize#>)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // TODO: Show toolbar and navbar
        self.toolbar?.isHidden = false
        self.navBar?.isHidden = false
        
        let frame = self.image!.frame
        
        let newFrame = CGRect(x: 0 + (self.view.frame.width/2 - self.image!.frame.width/2) ,
                              y: 0  + (self.view.frame.height/2 - self.image!.frame.height/2),
                                width: frame.width, height: frame.height)
        
        let sourceCGImage = memedImage.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: newFrame
        )!
        

        let finalImage = UIImage(cgImage: croppedCGImage)
        return finalImage
    }
    
    
    // MARK: - Cancel / Reset
    
    @IBAction func handleCancel(_ sender: Any) {
        print("cancelled")
        self.resetView()
    }
    
    func resetView() {
        self.topText?.text = "TOP"
        self.bottomText?.text = "BOTTOM"
        self.image?.image = nil
        self.actionButton?.isEnabled = false
    }
    


}

