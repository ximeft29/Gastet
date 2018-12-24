//
//  Posts.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 7/22/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class Posts {
    
    //Post ID
    var postid : String?
    
    //Likes
    var likeCount: Int?
    var likes: Dictionary<String, Any>?
    var isLiked : Bool?
    
    //UserView
    var uid: String?
    var author: UserProfile?
    var timestamp: Date?
    var userid: String?
    
    func getDateFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        return formatter.string(from: self.timestamp!)
    }
    
    //Image
    var photoUrl: URL?
    
    //PostInformation View
    var city: String?
    var municipality: String?
    var name: String?
    var breed : String?
    var phone : String?
    var address : String?
    var petType: String?
    var genderType: String?
    var comments: String?

}

extension Posts {
    
    static func transformPost(dict: [String: Any], key: String) -> Posts {
        
        let post = Posts()
    
        //Post Id
        post.postid = key
        post.likeCount = dict["likeCount"] as? Int
        
        if let currentUserId = Auth.auth().currentUser?.uid {
            if post.likes != nil {
                post.isLiked = post.likes![currentUserId] !=  nil
        }
        

        }
        
        //Post Picture
        let photoUrl = dict["photoUrl"] as? String
        post.photoUrl = URL(string: photoUrl!)
        
        //INFO POSTS
        post.userid = dict["userid"] as? String
        post.city = dict["city"] as? String
        post.municipality = dict["municipality"] as? String
        post.name = dict["name"] as? String
        post.breed = dict["breed"] as? String
        post.phone = dict["phone"] as? String
        post.address = dict["address"] as? String
        post.comments = dict["comments"] as? String
        post.petType = dict["petType"] as? String
        post.genderType = dict["gender"] as? String
        let timestamp = dict["timestamp"] as? Double
        post.timestamp = Date(timeIntervalSince1970: timestamp!/1000)
        
        return post
        
    }
}

