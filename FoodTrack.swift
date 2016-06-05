//
//
//  FoodTrack.swift
//  BebeSano
//
//  Created by César Gutiérrez Tapiador on 30/5/16.
//  Copyright © 2016 César Gutiérrez Tapiador. All rights reserved.
//

import UIKit

class FoodTrack {
    
    //MARK: Properties
    var foodName: String
    var eventDate: NSDate
    var tolerated: BooleanType
    var comment: String
    
    //MARK: Initialization
    
    init?(foodName: String, eventDate: NSDate, tolerated: BooleanType, comment: String){
        
        //Initialize food track values
        self.foodName = foodName
        self.eventDate = eventDate
        self.tolerated = tolerated
        self.comment = comment
        
        if foodName.isEmpty  {
            return nil
        }
    }
}
