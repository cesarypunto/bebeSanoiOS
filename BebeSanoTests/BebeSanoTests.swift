//
//  BebeSanoTests.swift
//  BebeSanoTests
//
//  Created by César Gutiérrez Tapiador on 29/5/16.
//  Copyright © 2016 César Gutiérrez Tapiador. All rights reserved.
//

import XCTest
@testable import BebeSano

class BebeSanoTests: XCTestCase {
    
    // MARK: Child Tests
    // Tests to confirm that the Child initializer returns when no name.
    func testChildInitialization() {
        let potentialChild = Child(photo: nil, name: "Name", birthDate: NSDate() , gender: Child.EGender.Male )
        XCTAssertNotNil(potentialChild)
        
        // Failure cases.
        let noName = Child(photo: nil, name: "", birthDate: NSDate() , gender: Child.EGender.Male )
        XCTAssertNil(noName, "Empty name is invalid")
    }

    // Tests to confirm that the FoodTracker initializer returns when no name.
    func testFoodTrack() {
        let potentialFoodTrack = FoodTrack(foodName: "Name", eventDate: NSDate() , tolerated: true, comment: "")
        XCTAssertNotNil(potentialFoodTrack)
        
        // Failure cases.
        let noName = FoodTrack(foodName: "", eventDate: NSDate() , tolerated: true, comment: "")
        XCTAssertNotNil(potentialFoodTrack)
        XCTAssertNil(noName, "Empty name is invalid")
    }

    
}
