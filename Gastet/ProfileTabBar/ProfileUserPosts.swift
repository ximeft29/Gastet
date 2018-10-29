//
//  ProfileUserPosts.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 8/15/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProfileUserPosts: NSObject {
    
    //Image
    var photoUrl: URL
    
    //PostInformation View
    var name: String?
    var address: String?
    var breed : String?
    var phone : String?
    var city: String?
    var municipality: String

    var petType: String!
    var postType: String!
    var genderType: String?
    var comments: String!
    
    //Timestamp
    var timestamp: Date
    
    func getDateFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        return formatter.string(from: self.timestamp)
    }
    
    init(name: String, address: String, breed: String, phone: String, photoUrl: URL, city: String, municipality: String, petType: String, gender: String, timestamp: Date, postType: String, comments: String) {
        
        self.breed = breed
        self.phone = phone
        self.photoUrl = photoUrl
        self.city = city
        self.municipality = municipality
        self.petType = petType
        self.genderType = gender
        self.timestamp = timestamp
        self.postType = postType
        self.comments = comments
        self.name = name
        self.address = address
        
    }
}
