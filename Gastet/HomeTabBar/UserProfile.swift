//
//  UserProfile.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 7/27/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import Foundation

class UserProfile {
    
    var uid: String
    var username: String
    var photoUrl: URL
    
    init(uid: String, username: String, photoUrl: URL) {
        self.uid = uid
        self.username = username
        self.photoUrl = photoUrl
    
    }
    
}
