//
//  LostCollectionViewCell.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/29/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class LostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var postedLostUIImage: UIImageView!
    @IBOutlet weak var adressLostLabel: UILabel!
    @IBOutlet weak var breedLostLabel: UILabel!
    @IBOutlet weak var phoneLostTextView: UITextView!
    
    func set(post: Posts) {
        
        ImageService.getImage(withUrl: post.photoUrl) { (image) in
            self.postedLostUIImage.image = image
        }
        adressLostLabel.text = post.address
        breedLostLabel.text = post.breed
        phoneLostTextView.text = post.phone
    }
    
    
    }

