//
//  FoundSelectedViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 10/23/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class FoundSelectedViewController: UIViewController {

    //Vars
    var postsfound: PostsFound?
    
    //@IBOUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Data
    @IBOutlet weak var foundImage: UIImageView!
    @IBOutlet weak var postTypeImage: UIImageView!
    @IBOutlet weak var postTypeLabel: UILabel!
    @IBOutlet weak var petTypeImage: UIImageView!
    @IBOutlet weak var petTypeLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    //User
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    //Address View
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var municipalityLabel: UILabel!
    
    
    //@IBACTIONS
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func contactmeButtonTapped(_ sender: UIButton) {
        let phoneNumber = postsfound?.phonefound
        if let callNumber = phoneNumber, let aURL = NSURL(string: "telprompt://\(callNumber)") {
            
            
            if UIApplication.shared.canOpenURL(aURL as URL) {
                UIApplication.shared.openURL(aURL as URL)
            } else {
                print("error")
            }
        }
        else {
            ProgressHUD.showSuccess("Ha hábido un error, intenta más tarde")
            print("error")
            
        }
    }
    
    
    @IBAction func shareWhattsappButtonTapped(_ sender: UIButton) {
        
        let shareMessage = "Hola! Encontre a este \(postsfound?.petTypeFound) de raza \(postsfound?.breedfound). Ayudenme a encontrar su dueño porfavor! Subi la foto con toda la información en Gastet. Pueden verlo aquí : https://itunes.apple.com/mx/app/gastet/id1407059324?l=en&mt=8"
        
        shareWhatssapp(message: shareMessage)
    }
    
    func shareWhatssapp(message: String) {
        
        let msg = message
        let urlWhats = "whatsapp://send?text=\(msg)"
        if  let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if  UIApplication.shared.canOpenURL(whatsappURL as URL ) {
                    UIApplication.shared.open(whatsappURL as URL)
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //scroll view
        scrollView.delegate = self
        
        
        //navbar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //Loading information from post
        
        self.foundImage.image = nil
        
        ImageService.getImage(withUrl:(postsfound?.photoUrlfound)! ) { (image) in
            
            self.foundImage.image = image
            
        }
        
        
        //Post Data
        self.postTypeLabel.text = "Encontrado"
        self.postTypeImage.image = UIImage.init(named: "postType_found.png")
        
        //PetType
        switch postsfound?.petTypeFound {
            
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
        
        self.breedLabel.text =  postsfound?.breedfound
        
        //Gender
        switch postsfound?.genderTypeFound {
       
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
        self.userLabel.text = postsfound?.authorfound.username
        
        self.userProfilePicture.image = nil
        ImageService.getImage(withUrl: (postsfound?.authorfound.photoUrl)!) { (image) in
            
            self.userProfilePicture.image = image
        }
        
        
        //Address
        self.cityLabel.text = postsfound?.cityfound
        self.municipalityLabel.text = postsfound?.municipalityfound
        self.addressLabel.text = postsfound?.addressfound
        
        //Comments
        self.commentsLabel.text = postsfound?.comments
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension  FoundSelectedViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    
}
