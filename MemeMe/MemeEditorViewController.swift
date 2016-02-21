//
//  ViewController.swift
//  MemeMe
//
//  Created by Gareth Hunt on 25/01/2016.
//  Copyright © 2016 ghunt03. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Outlets
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var pickFromAlbumButton: UIBarButtonItem!
    @IBOutlet weak var pickFromCameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meme: Meme?
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    //default appearence of text fields (next version should allow for the changing of fonts and colors)
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "Impact", size: 35)!,
        NSStrokeWidthAttributeName: -5.0
        
    ]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (meme != nil) {
            prepareTextField(topTextField, defaultString: (meme?.topText)!)
            prepareTextField(bottomTextField, defaultString: (meme?.bottomText)!)
            imageViewer.image = meme?.originalImage
        }
        else {
            prepareTextField(topTextField, defaultString: "TOP")
            prepareTextField(bottomTextField, defaultString: "BOTTOM")
        }
        
    }

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //disable camera button if not available
        pickFromCameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        //disable share button until image is picked
        shareButton.enabled = (imageViewer.image != nil)
        saveButton.enabled = (imageViewer.image != nil)
        subscribeToKeyboardNotifications()
    }
    
    func prepareTextField(textField: UITextField, defaultString: String) {
        // Set default settings for the appearence for text fields
        textField.delegate = memeTextFieldDelegate
        textField.text = defaultString
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func pickImage(imgSource: String) {
        //shared function for showing image picker controller
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if (imgSource == "Album") {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        else {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        }
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        pickImage("Album")
    }
    
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        pickImage("Camera")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageViewer.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func shareMeme(sender: AnyObject) {
        //share / saving memem
        let memed_image = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memed_image], applicationActivities: [])
        activityController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                self.saveMeme(memed_image)
            }
        }
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillhide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    func keyboardWillhide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        //function for determining the height of the keyboard when editing the bottom text field. If editing top text field returns 0
        if bottomTextField.editing {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
            return keyboardSize.CGRectValue().height
        }
        else {
            return 0
        }
        
        
    }
    
    func saveMeme(memed_image: UIImage) {
        let meme = Meme(topText:topTextField.text!, bottomText: bottomTextField.text!, originalImage:imageViewer.image!, memedImage: memed_image)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveNewMeme(sender: AnyObject) {
        let memed_image = generateMemedImage()
        saveMeme(memed_image)
    }
    
    @IBAction func cancelNewMeme(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func generateMemedImage()->UIImage{
        //hide navbar and toolbar
        navBar.hidden = true
        toolbar.hidden = true
        
        //capture image with no scaling
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0.0)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //show navbar and toolbar
        navBar.hidden = false
        toolbar.hidden = false
        return memedImage
    }

}

