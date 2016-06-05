//
//  PercentileViewController.swift
//  BebeSano
//
//  Created by César Gutiérrez Tapiador on 3/6/16.
//  Copyright © 2016 César Gutiérrez Tapiador. All rights reserved.
//

import UIKit

class PercentileViewController: UIViewController {

    //MARK: Porperties
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heigthTextField: UITextField!
    @IBOutlet weak var trackDateTextField: UITextField!
    
    @IBOutlet weak var weightPercentileLabel: UILabel!
    
    @IBOutlet weak var heightPercentileLabel: UILabel!
    
    
    var child: Child?
    var percentile: Percentile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        heightPercentileLabel.hidden = false
        weightPercentileLabel.hidden = false
        
        let formatter = NSDateFormatter()
        let gbDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "es-ES"))
        formatter.dateFormat = gbDateFormat
        
        // get child data.
        if let child = child {
            navigationItem.title = child.name
            heightPercentileLabel.text   = formatter.stringFromDate(child.birthDate)
            weightPercentileLabel.text = child.gender.rawValue
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dateFieldEditing(sender: UITextField) {
        
        self.view.endEditing(true)
        trackDateTextField.resignFirstResponder()
        
        DatePickerDialog().show("Selecciona una fecha", doneButtonTitle: "Aceptar", cancelButtonTitle: "Cancelar", datePickerMode: .Date) {
            (date) -> Void in
            
            //Format date
            let formatter = NSDateFormatter()
            let gbDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "es-ES"))
            formatter.dateFormat = gbDateFormat
            
            self.trackDateTextField.text = formatter.stringFromDate(date)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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

}
