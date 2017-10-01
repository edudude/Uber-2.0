//
//  DataService.swift
//  Uber 2.0
//
//  Created by Alex Wong on 10/1/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation
import Firebase

let database = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = database
    private var _REF_USERS = database.child("users")
    private var _REF_DRIVERS = database.child("drivers")
    private var _REF_TRIPS = database.child("trips")
    
    // create another variable to access these private vars
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    
    var REF_DRIVERS: DatabaseReference{
        return _REF_DRIVERS
    }
    
    var REF_TRIPS: DatabaseReference{
        return _REF_TRIPS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String,Any>, isDriver: Bool){
        if isDriver{
            REF_DRIVERS.child(uid).updateChildValues(userData)
        } else {
            REF_USERS.child(uid).updateChildValues(userData)
        }
        
    }
    
}
