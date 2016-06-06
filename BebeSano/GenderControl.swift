//
//  GenderControl.swift
//  BebeSano
//
//  Created by César Gutiérrez Tapiador on 29/5/16.
//  Copyright © 2016 César Gutiérrez Tapiador. All rights reserved.
//

import UIKit

class GenderControl: UIView {
    
    // MARK: Properties
    var genderButtons = [UIButton]()
    var gender : Child.EGender!
    
    let spacing = 5
    //let controlWidth = 105

    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        gender = Child.EGender.Male //default value
        
        let maleOnImage = UIImage(named: "maleOn")
        let maleOffImage = UIImage(named: "maleOff")
        let femaleOnImage = UIImage(named: "femaleOn")
        let femaleOffImage = UIImage(named: "femaleOff")

        
        
        //Male [0]
        let buttonMale = UIButton()
        buttonMale.setImage(maleOffImage, forState: .Normal)
        buttonMale.setImage(maleOnImage, forState: .Selected)
        buttonMale.setImage(maleOnImage, forState: [.Highlighted, .Selected])
        
        buttonMale.adjustsImageWhenHighlighted = false
        buttonMale.selected = true
        
        buttonMale.addTarget(self, action: #selector(GenderControl.genderButtonMaleTapped(_:)), forControlEvents: .TouchDown)
        genderButtons += [buttonMale]
        addSubview(buttonMale)
        
        //Female [1]
        let buttonFemale = UIButton()
        buttonFemale.setImage(femaleOffImage, forState: .Normal)
        buttonFemale.setImage(femaleOnImage, forState: .Selected)
        buttonFemale.setImage(femaleOnImage, forState: [.Highlighted, .Selected])
        
        buttonFemale.adjustsImageWhenHighlighted = false
        
        buttonFemale.addTarget(self, action: #selector(GenderControl.genderButtonFemaleTapped(_:)), forControlEvents: .TouchDown)
        genderButtons += [buttonFemale]
        addSubview(buttonFemale)

    }
    
    override func layoutSubviews() {
        
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in genderButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
    }
    
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * 2) + (spacing * (2 - 1))
        
        return CGSize(width: width, height: buttonSize)
    }
    
    func getGender() -> Child.EGender{
            return gender
    }
    
    // MARK: Button Action
    func genderButtonMaleTapped(button: UIButton) {
        gender = Child.EGender.Male
        genderButtons[0].selected = true
        genderButtons[1].selected = false
    }
    
    func genderButtonFemaleTapped(button: UIButton) {
        gender = Child.EGender.Female
        genderButtons[0].selected = false
        genderButtons[1].selected = true
        
    }
    

}
