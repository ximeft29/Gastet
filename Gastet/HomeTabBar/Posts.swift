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

    var address : String?
    var breed : String?
    var phone : String?
    var photoUrl: URL
    
    init(address: String, breed: String, phone: String, photoUrl: URL) {
        
        self.address = address
        self.breed = breed
        self.phone = phone
        self.photoUrl = photoUrl
    }
   }
