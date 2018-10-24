//
//  PostsFound.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 7/26/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class PostsFound: NSObject {

    
//    UserView
    var uid: String
    var authorfound: UserProfile
    var timestampfound: Date
    
    func getDateFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        return formatter.string(from: self.timestampfound)
    }
    
    //Image
    var photoUrlfound: URL
    
    //PostInformation View
    var cityfound: String?
    var municipalityfound: String
    var breedfound : String?
    var phonefound : String?
    var addressfound : String?
    var petTypeFound: String!
    var genderTypeFound: String?
    var comments: String?
    
    
    init(uid: String, authorfound: UserProfile, addressfound: String, breedfound: String, phonefound: String, photoUrlfound: URL, cityfound: String, municipalityfound: String, petTypeFound: String, genderfound: String, timestampfound: Date, comments: String) {
        
        self.addressfound = addressfound
        self.breedfound = breedfound
        self.phonefound = phonefound
        self.photoUrlfound = photoUrlfound
        self.cityfound = cityfound
        self.municipalityfound = municipalityfound
        self.authorfound = authorfound
        self.uid = uid
        self.petTypeFound = petTypeFound
        self.genderTypeFound = genderfound
        self.timestampfound = timestampfound
        self.comments = comments

        
    }

    
}
