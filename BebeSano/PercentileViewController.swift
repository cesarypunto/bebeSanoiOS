//
//  PercentileViewController.swift
//  BebeSano
//
//  Created by César Gutiérrez Tapiador on 3/6/16.
//  Copyright © 2016 César Gutiérrez Tapiador. All rights reserved.
//

import UIKit

class PercentileViewController: UIViewController, UITextFieldDelegate {

    //MARK: Porperties
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heigthTextField: UITextField!
    @IBOutlet weak var trackDateTextField: UITextField!
    
    @IBOutlet weak var weightPercentileLabel: UILabel!
    
    @IBOutlet weak var heightPercentileLabel: UILabel!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    var birthDate: NSDate!
    var gender: Child.EGender!
    var child: Child?
    var percentile: Percentile?
    var formatter: NSDateFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calculateButton.hidden = true
        
        
        weightTextField.delegate = self
        heigthTextField.delegate = self
        trackDateTextField.delegate = self

        // Do any additional setup after loading the view.
        
        heightPercentileLabel.hidden = false
        weightPercentileLabel.hidden = false
        
        self.formatter = NSDateFormatter()
        let gbDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "es-ES"))
        self.formatter.dateFormat = gbDateFormat
        
        // get child data.
        if let child = child {
            navigationItem.title = child.name

            heightPercentileLabel.text   = formatter.stringFromDate(child.birthDate)
            birthDate = child.birthDate
            weightPercentileLabel.text = child.gender.rawValue
            gender = child.gender
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkTextFields()
    }
    
    
    func checkTextFields() {
        // Disable save if empty fields.
        let complete = !(weightTextField.text?.isEmpty)! && !(heigthTextField.text?.isEmpty)! && !(trackDateTextField.text?.isEmpty)!
        
        
        calculateButton.hidden = !complete
    }
    

    @IBAction func dateFieldEditing(sender: UITextField) {
        
        self.view.endEditing(true)
        trackDateTextField.resignFirstResponder()
        
        DatePickerDialog().show("Selecciona una fecha", doneButtonTitle: "Aceptar", cancelButtonTitle: "Cancelar", datePickerMode: .Date) {
            (date) -> Void in
            
            self.trackDateTextField.text = self.formatter.stringFromDate(date)
        }
    }
    
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func showPercentile(sender: UIButton) {
        
        let weight = (weightTextField.text! as NSString).floatValue
        weightTextField.text =  NSString(format: "%.2f", weight) as String
        let heigth = (heigthTextField.text! as NSString).floatValue
        heigthTextField.text = NSString(format: "%.2f", heigth) as String
        
        if !weight.isNaN && !heigth.isNaN && !weight.isSignMinus && !heigth.isSignMinus
        {
                percentile = Percentile(birthDate: birthDate, trackDate: self.formatter.dateFromString(trackDateTextField.text!)!, gender: gender, weight: weight, height:heigth)
        }
    }
    
}
