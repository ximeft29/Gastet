//
//  LostCollectionViewCell.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/29/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FBSDKShareKit

class LostCollectionViewCell: UICollectionViewCell {
    

    // UserView
    @IBOutlet weak var usernameLostLabel: UILabel!
    @IBOutlet weak var userLostImage: UIImageView!
    @IBOutlet weak var timestampLostLabel: UILabel!
    
    // Image
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var postedLostUIImage: UIImageView!
    
    // PostInformation View
    @IBOutlet weak var cityLostLabel: UILabel!
    @IBOutlet weak var municipalityLostLabel: UILabel!
    @IBOutlet weak var nameLostLabel: UILabel!
    @IBOutlet weak var breedLostLabel: UILabel!
    @IBOutlet weak var phoneLostTextView: UITextView!
    @IBOutlet weak var adressLostLabel: UILabel!


//    PostInformation PetType/Gender Pictures
    @IBOutlet weak var petTypeLostImage: UIImageView!
    @IBOutlet weak var genderLostImage: UIImageView!

    
    
    
    func set(post: Posts) {
        
        func getDateFormattedString() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, HH:mm"
            return formatter.string(from: post.timestamp)
        }
        
        self.postedLostUIImage.image = nil
        ImageService.getImage(withUrl: post.photoUrl) { (image) in
            self.postedLostUIImage.image = image
        }
        
        self.userLostImage.image = nil
        
        if let photoUrl = post.author.photoUrl {
            
            ImageService.getImage(withUrl: photoUrl) { (image) in
                self.userLostImage.image = image
            }
            
        }
        

        
        adressLostLabel.text = "Ultima vez visto en " + post.address!
        nameLostLabel.text = post.name
        breedLostLabel.text = post.breed
        phoneLostTextView.text = post.phone
        cityLostLabel.text = post.city
        municipalityLostLabel.text = post.municipality
        usernameLostLabel.text = post.author.username
        timestampLostLabel.text = "\(post.getDateFormattedString())"
        
        switch post.petType{
            
        case "dog":
           petTypeLostImage.image = UIImage(named: "petType_dog.png")
            break
        case "cat":
            petTypeLostImage.image = UIImage(named: "petType_cat.png")
            break
        case "other":
            petTypeLostImage.image = UIImage(named: "petType_other.png")
            break
        default:
            break
        }
        
        switch post.genderType {
        case "male":
           genderLostImage.image = UIImage(named: "gender_male.png")
            break
        case "female":
            genderLostImage.image = UIImage(named: "gender_female.png")
            break
        default:
            break
        }
        
    }
    }

