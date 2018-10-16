//
//  FoundCollectionViewCell.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/30/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class FoundCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var postedFoundUIImage: UIImageView!
    @IBOutlet weak var adressFoundLabel: UILabel!
    @IBOutlet weak var breedFoundLabel: UILabel!
    @IBOutlet weak var phoneFoundTextView: UITextView!
    
    func set(postfound: PostsFound) {
        
        ImageService.getImage(withUrl: postfound.photoUrlfound) { (image) in
            self.postedFoundUIImage.image = image
        }
        adressFoundLabel.text = postfound.addressfound
        breedFoundLabel.text = postfound.breedfound
        phoneFoundTextView.text = postfound.phonefound
    }
}
