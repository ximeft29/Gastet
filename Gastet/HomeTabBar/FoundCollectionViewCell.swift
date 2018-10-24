 //
//  FoundCollectionViewCell.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/30/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class FoundCollectionViewCell: UICollectionViewCell {
    
    
    //UserView
    @IBOutlet weak var usernameFoundLabel: UILabel!
    @IBOutlet weak var userFoundImage: UIImageView!
    @IBOutlet weak var timestampFoundLabel: UILabel!
    
    
    //Image
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var postedFoundUIImage: UIImageView!
    
    //PostInformation View
    @IBOutlet weak var cityFoundLabel: UILabel!
    @IBOutlet weak var municipalityFoundLabel: UILabel!
    @IBOutlet weak var breedFoundLabel: UILabel!
    @IBOutlet weak var phoneFoundTextView: UITextView!
    @IBOutlet weak var adressFoundLabel: UILabel!
    
    //PostInformation PetType/Gender Pictures
    @IBOutlet weak var petTypeFoundImage: UIImageView!
    @IBOutlet weak var genderTypeFoundImage: UIImageView!

    func set(postfound: PostsFound) {
        
        self.postedFoundUIImage.image = nil
        ImageService.getImage(withUrl: postfound.photoUrlfound) { (image) in
            self.postedFoundUIImage.image = image
        }
        
        self.userFoundImage.image = nil
        ImageService.getImage(withUrl: postfound.authorfound.photoUrl) { (image) in
            
            
            self.userFoundImage.image = image
        }
        
        adressFoundLabel.text = "Se encontro en " + postfound.addressfound!
        breedFoundLabel.text = postfound.breedfound
        phoneFoundTextView.text = postfound.phonefound
        cityFoundLabel.text = postfound.cityfound
        municipalityFoundLabel.text = postfound.municipalityfound
        usernameFoundLabel.text = postfound.authorfound.username
        timestampFoundLabel.text = "\(postfound.getDateFormattedString())"
        

        switch postfound.petTypeFound{
            
        case "dog":
            petTypeFoundImage.image = UIImage(named: "petType_dog.png")
            break
        case "cat":
            petTypeFoundImage.image = UIImage(named: "petType_cat.png")
            break
        case "other":
            petTypeFoundImage.image = UIImage(named: "petType_other.png")
            break
        default:
            break
        }
        
        switch postfound.genderTypeFound {
        case "male":
            genderTypeFoundImage.image = UIImage(named: "gender_male.png")
            break
        case "female":
            genderTypeFoundImage.image = UIImage(named: "gender_female.png")
            break
        default:
            break
        }
        
    }
}
