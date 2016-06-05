//
//  Child.swift
//  BebeSano
//
//  Created by César Gutiérrez Tapiador on 29/5/16.
//  Copyright © 2016 César Gutiérrez Tapiador. All rights reserved.
//

import UIKit

class Child: NSObject, NSCoding {
    
    enum EGender : String{
        case Male = "male"
        case Female = "female"
    }

    
    // MARK: Properties
    
    var photo: UIImage?
    var name: String
    var birthDate: NSDate
    var gender: EGender
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("children")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let birthDateKey = "birthDate"
        static let genderKey = "gender"
    }
    
    // MARK: Initialization
    
    init?(photo: UIImage?, name: String,  birthDate: NSDate, gender: EGender) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.birthDate = birthDate
        self.gender = gender
        
        super.init()
        
        if name.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(birthDate, forKey: PropertyKey.birthDateKey)
        aCoder.encodeObject(gender.rawValue, forKey: PropertyKey.genderKey )
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let birthDate = aDecoder.decodeObjectForKey(PropertyKey.birthDateKey) as! NSDate
        let gender = EGender(rawValue: (aDecoder.decodeObjectForKey(PropertyKey.genderKey ) as! String))
        
        self.init(photo: photo, name: name,  birthDate: birthDate, gender: gender!)
    }
}