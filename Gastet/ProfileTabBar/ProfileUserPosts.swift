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
    var breed : String?
    var phone : String?
    var postType: String!
    var petType: String!
    var genderType: String?
    var comments: String!
    
    init(breed: String, phone: String, photoUrl: URL, city: String, municipality: String, petType: String, gender: String, timestamp: Date, postType: String, comments: String) {
        
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
        
    }

}
