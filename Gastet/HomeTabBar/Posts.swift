//
//  Posts.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 7/22/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Posts: NSObject {

//    UserView
    var uid: String
    var author: UserProfile
    var timestamp: Date
    
    func getDateFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        return formatter.string(from: self.timestamp)
    }
    
    //Image
    var photoUrl: URL
    
    //PostInformation View
    var city: String?
    var municipality: String
    var name: String
    var breed : String?
    var phone : String?
    var address : String?
    var petType: String!
    var genderType: String?
    var comments: String?
    
    init(uid: String, author: UserProfile, name: String, address: String, breed: String, phone: String, photoUrl: URL, city: String, municipality: String, petType: String, gender: String, timestamp: Date, comments: String) {
        
        self.address = address
        self.breed = breed
        self.phone = phone
        self.photoUrl = photoUrl
        self.city = city
        self.municipality = municipality
        self.author = author
        self.uid = uid
        self.name = name
        self.petType = petType
        self.genderType = gender
        self.timestamp = timestamp
        self.comments = comments
        
    }
   }
