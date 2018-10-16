//
//  PostsCollectionViewCell.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 8/14/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var postUIImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var phoneLabel: UITextView!

    
    func set(post: ProfileUserPosts) {

        ImageService.getImage(withUrl: post.photoUrl) { (image) in
            self.postUIImage.image = image
        }
        
        addressLabel.text = post.address
        breedLabel.text = post.breed
        phoneLabel.text = post.phone

        
    }
}
