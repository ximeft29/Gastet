//
//  LostSelectedViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 10/23/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class LostSelectedViewController: UIViewController {


    //Variables
    var posts: Posts?
    
    //@IBOUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Data
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lostImage: UIImageView!
    @IBOutlet weak var postTypeImage: UIImageView!
    @IBOutlet weak var postTypeLabel: UILabel!
    @IBOutlet weak var petTypeImage: UIImageView!
    @IBOutlet weak var petTypeLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    
    //User
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    //Address View
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var municipalityLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    //@IBACTIONS
    @IBAction func cancelButtonTapped(_ sender: UIButton) {

    self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func callMeButtonTapped(_ sender: UIButton) {
        
//        let phoneNumber = posts?.phone
//        let phoneURL = NSURL(string: "tel:\(phoneNumber)")
//
////        let phoneNumber = "123-456-789"
////        let phoneURL = NSURL(string: "tel:\(phoneNumber)")!
////        if UIApplication.sharedApplication().canOpenURL(phoneURL) {
////            UIApplication.sharedApplication().openURL(phoneURL)
////        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navbar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //scroll view
        scrollView.delegate = self
        
        
        //imagenes
        
        self.lostImage.image = nil

        ImageService.getImage(withUrl:(posts?.photoUrl)! ) { (image) in

            self.lostImage.image = image
 
        }
        
        //Post Data
        self.nameLabel.text = posts?.name
        self.postTypeLabel.text = "Perdido"
        self.postTypeImage.image = UIImage.init(named: "postType_lost.png")
        
        //PetType
        switch posts?.petType{
            
        case "dog":
            petTypeLabel.text = "Perro"
            petTypeImage.image = UIImage(named: "petType_dog.png")
            break
        case "cat":
            petTypeLabel.text = "Gato"
            petTypeImage.image = UIImage(named: "petType_cat.png")
            break
        case "other":
            petTypeLabel.text = "Otro"
            petTypeImage.image = UIImage(named: "petType_other.png")
            break
        default:
            break
        }
        
        self.breedLabel.text = posts?.breed
        
        //Gender
        switch posts?.genderType {
        case "male":
            genderLabel.text = "Macho"
            genderImage.image = UIImage(named: "genderPost_male.png")
            break
        case "female":
            genderLabel.text = "Hembra"
            genderImage.image = UIImage(named: "genderPost_female.png")
            break
        default:
            break
        }
        
        //Username
        
        self.userProfilePicture.image = nil
        ImageService.getImage(withUrl: (posts?.author.photoUrl)!) { (image) in
            
            self.userProfilePicture.image = image
        }
        self.userLabel.text = posts?.author.username

        //Address
        self.cityLabel.text = posts?.city
        self.municipalityLabel.text = posts?.municipality
        self.addressLabel.text = posts?.address
        
        //Comments
        self.commentsLabel.text = posts?.comments
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension  LostSelectedViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    
}
