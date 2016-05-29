//
//  ViewController.swift
//  BebeSano
//
//  Created by César Gutiérrez Tapiador on 29/5/16.
//  Copyright © 2016 César Gutiérrez Tapiador. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
        
    @IBOutlet weak var dateTextField: UITextField!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //datePicker.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dateFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged),forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        /*dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle*/
       
        
        let formatter = NSDateFormatter()
        let gbDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "es-ES"))
        
        
        formatter.dateFormat = gbDateFormat
        
        dateTextField.text = formatter.stringFromDate(sender.date)
        
    }


}

