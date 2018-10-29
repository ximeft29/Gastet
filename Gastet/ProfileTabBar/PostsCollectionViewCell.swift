//
//  PostsCollectionViewCell.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 8/14/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var postUIImage: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var phoneLabel: UITextView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var municipalityLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    //PostInformation PetType/Gender Pictures
    @IBOutlet weak var postTypeImage: UIImageView!
    @IBOutlet weak var genderImage: UIImageView!
    
    
    
    func set(post: ProfileUserPosts) {

        ImageService.getImage(withUrl: post.photoUrl) { (image) in
            self.postUIImage.image = image
        }
        
        breedLabel.text = post.breed
        phoneLabel.text = post.phone
        commentsLabel.text = post.comments
        cityLabel.text = post.city
        municipalityLabel.text = post.municipality
        
        //PostType
        
        switch post.postType {
        case "lost":
            postTypeImage.image = UIImage(named: "postType_lost.png")
            break
        case "found":
            postTypeImage.image = UIImage(named: "postType_found.png")
            break
        case "adopt":
            postTypeImage.image = UIImage(named: "postType_adoption.png")
            break
        default:
            break
        }
        
        //Gender
        switch post.genderType {
        case "male":
            genderImage.image = UIImage(named: "gender_male.png")
            break
        case "female":
            genderImage.image = UIImage(named: "gender_female.png")
            break
        default:
            break
        }
        
    }
}
