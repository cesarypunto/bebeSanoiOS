//
//  ChildViewController.swift
//  BebeSano
//
//  Created by César Gutiérrez Tapiador on 29/5/16.
//  Copyright © 2016 César Gutiérrez Tapiador. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    //MARK: Properties
        
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var genderControl: GenderControl!
    
    var child: Child?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        dateTextField.delegate = self

         saveButton.enabled = false
        
        //Show round image
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2;
        self.photoImageView.clipsToBounds = true;
        
        //self.photoImageView.layer.cornerRadius = 10.0

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkTextFields()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkTextFields() {
        // Disable save if empty fields.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    

    
    //MARK: Actions

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        // Only photo Library
        imagePickerController.sourceType = .PhotoLibrary
        
        //Notify to ViewController.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    
    
    @IBAction func dateFieldEditing(sender: AnyObject) {
        
        DatePickerDialog().show("Selecciona una fecha", doneButtonTitle: "Aceptar", cancelButtonTitle: "Cancelar", datePickerMode: .Date) {
            (date) -> Void in
            
            //Format date
            let formatter = NSDateFormatter()
            let gbDateFormat = NSDateFormatter.dateFormatFromTemplate("ddMMyyyy", options: 0, locale: NSLocale(localeIdentifier: "es-ES"))
            formatter.dateFormat = gbDateFormat
            
            self.dateTextField.text = formatter.stringFromDate(date)
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //Cancel selection
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Display image.
        photoImageView.image = cropToBounds(selectedImage, width: 200, height: 200)
        
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK: Functions
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let contextImage: UIImage = UIImage(CGImage: image.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    // MARK: Navigation
    // Configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let birthDate = dateFormatter.dateFromString(dateTextField.text!)
            let gender = genderControl.getGender()
            
            //Create new child
            child = Child(photo: photo, name: name, birthDate: birthDate!, gender: gender)
        }
    }
    
}

