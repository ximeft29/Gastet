//
//  PostsAdoption.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 10/18/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import Foundation

class PostsAdoption: NSObject {

    
    //    UserView
    var uid: String
    var authoradoption: UserProfile
    var timestampadoption: Date
    
    func getDateFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        return formatter.string(from: self.timestampadoption)
    }
    
    
    //Image
    var photoUrladoption: URL
    
    //PostInformation View
    var cityadoption: String?
    var municipalityadoption: String
    var breedadoption : String?
    var phoneadoption : String?
    var commentsadoption : String?
    var petTypeAdoption: String!
    var genderTypeAdoption: String?
    
    
    init(uid: String, authoradoption: UserProfile, commentsadoption: String, breedadoption: String, phoneadoption: String, photoUrladoption: URL, cityadoption: String, municipalityadoption: String, petTypeAdoption: String, genderadoption: String, timestampadoption: Date) {
        
        self.commentsadoption = commentsadoption
        self.breedadoption = breedadoption
        self.phoneadoption = phoneadoption
        self.photoUrladoption = photoUrladoption
        self.cityadoption = cityadoption
        self.municipalityadoption = municipalityadoption
        self.authoradoption = authoradoption
        self.uid = uid
        self.petTypeAdoption = petTypeAdoption
        self.genderTypeAdoption = genderadoption
        self.timestampadoption = timestampadoption
        
    }
    





}
