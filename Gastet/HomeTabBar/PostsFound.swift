//
//  PostsFound.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 7/26/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class PostsFound: NSObject {

    var addressfound : String?
    var breedfound : String?
    var phonefound : String?
    var photoUrlfound: URL
    
    init(addressfound: String, breedfound: String, phonefound: String, photoUrlfound: URL) {
        
        self.addressfound = addressfound
        self.breedfound = breedfound
        self.phonefound = phonefound
        self.photoUrlfound = photoUrlfound
        
    }

    
}
