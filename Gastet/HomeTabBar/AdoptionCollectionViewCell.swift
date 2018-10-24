//
//  AdoptionCollectionViewCell.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 10/18/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class AdoptionCollectionViewCell: UICollectionViewCell {
    
    
    //UserView
    @IBOutlet weak var usernameAdoptionLabel: UILabel!
    @IBOutlet weak var userAdoptionImage: UIImageView!
    @IBOutlet weak var timestampAdoptionLabel: UILabel!
    
    
    //Image
    @IBOutlet weak var postedAdoptionUIImage: UIImageView!
    
    //PostInformation View
    @IBOutlet weak var cityAdoptionLabel: UILabel!
    @IBOutlet weak var municipalityAdoptionLabel: UILabel!
    @IBOutlet weak var breedAdoptionLabel: UILabel!
    @IBOutlet weak var phoneAdoptionTextView: UITextView!
    @IBOutlet weak var commentsAdoptionLabel: UILabel!
    
    //PostInformation PetType/Gender Pictures
    @IBOutlet weak var petTypeAdoptionImage: UIImageView!
    @IBOutlet weak var genderTypeAdoptionImage: UIImageView!
    
    func set(postadoption: PostsAdoption) {
        
        ImageService.getImage(withUrl: postadoption.photoUrladoption) { (image) in

            self.postedAdoptionUIImage.image = image
        }

        ImageService.getImage(withUrl: postadoption.authoradoption.photoUrl) { (image) in

            self.userAdoptionImage.image = image
        }
        
        commentsAdoptionLabel.text = postadoption.commentsadoption
        breedAdoptionLabel.text = postadoption.breedadoption
        phoneAdoptionTextView.text = postadoption.phoneadoption
        cityAdoptionLabel.text = postadoption.cityadoption
        municipalityAdoptionLabel.text = postadoption.municipalityadoption
        usernameAdoptionLabel.text = postadoption.authoradoption.username
        timestampAdoptionLabel.text = "\(postadoption.getDateFormattedString())"
        
        
        switch postadoption.petTypeAdoption{
            
        case "dog":
            petTypeAdoptionImage.image = UIImage(named: "petType_dog.png")
            break
        case "cat":
            petTypeAdoptionImage.image = UIImage(named: "petType_cat.png")
            break
        case "other":
            petTypeAdoptionImage.image = UIImage(named: "petType_other.png")
            break
        default:
            break
        }
        
        switch postadoption.genderTypeAdoption {
        case "male":
            genderTypeAdoptionImage.image = UIImage(named: "gender_male.png")
            break
        case "female":
            genderTypeAdoptionImage.image = UIImage(named: "gender_female.png")
            break
        default:
            break
        }

    }
}
