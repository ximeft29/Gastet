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
    @IBOutlet weak var cityFoundLabel: UILabel!
    @IBOutlet weak var municipalityFoundLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    //PostInformation PetType/Gender Pictures
    @IBOutlet weak var petTypeFoundImage: UIImageView!
    @IBOutlet weak var genderTypeFoundImage: UIImageView!
    
    func set(post: ProfileUserPosts) {

        ImageService.getImage(withUrl: post.photoUrl) { (image) in
            self.postUIImage.image = image
        }
        
        breedLabel.text = post.breed
        phoneLabel.text = post.phone
        
    }
}
