//
//  AdoptionSelectedViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 10/24/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class AdoptionSelectedViewController: UIViewController {

    //VARIABLES
    var postsadoption: PostsAdoption?
    
    //@IBOUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Data
    
    @IBOutlet weak var adoptionImage: UIImageView!
    @IBOutlet weak var postTypeImage: UIImageView!
    @IBOutlet weak var postTypeLabel: UILabel!
    @IBOutlet weak var petTypeImage: UIImageView!
    @IBOutlet weak var petTypeLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    
    //User
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    //Address View
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var municipalityLabel: UILabel!
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func contactmeButtonTapped(_ sender: UIButton) {
        
        let phoneNumber = postsadoption?.phoneadoption
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
        
        switch postsadoption?.petTypeAdoption {
        case "dog":
            let shareMessage = "Hola! Tenemos un perro en adopción que es de raza \(postsadoption!.breedadoption!). Ayudenme a encontrarle una casa! Subi la foto con toda la información a Gastet. Pueden verlo aquí: https://itunes.apple.com/mx/app/gastet/id1407059324?l=en&mt=8"
            shareWhatssapp(message: shareMessage)
            
            break
            
        case "cat":
            let shareMessage = "Hola! Encontre a un gato en adopción que es de raza \(postsadoption!.breedadoption!). Ayudenme a encontrarle una casa! Subi la foto con toda la información a Gastet. Pueden verlo aquí: https://itunes.apple.com/mx/app/gastet/id1407059324?l=en&mt=8"
            shareWhatssapp(message: shareMessage)
            break
            
        case "other":
            let shareMessage = "Hola! Encontre a una mascota en adopción que es de raza \(postsadoption!.breedadoption!). Ayudenme a encontrarle una casa!Subi la foto con toda la información a Gastet. Pueden verlo aquí: https://itunes.apple.com/mx/app/gastet/id1407059324?l=en&mt=8"
            shareWhatssapp(message: shareMessage)
            break
        default:
            break
        }
        
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
        
        self.adoptionImage.image = nil
        
        ImageService.getImage(withUrl:(postsadoption?.photoUrladoption)! ) { (image) in
            
            self.adoptionImage.image = image
            
        }
        
        
        //Post Data
        self.postTypeLabel.text = "Adopción"
        self.postTypeImage.image = UIImage.init(named: "postType_adoption.png")
        
        //PetType
        switch postsadoption?.petTypeAdoption{
            
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
        
        self.breedLabel.text =  postsadoption?.breedadoption
        
        //Gender
        switch postsadoption?.genderTypeAdoption {
            
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
        self.userLabel.text = postsadoption?.authoradoption.username
        
        self.userProfilePicture.image = nil
        ImageService.getImage(withUrl: (postsadoption?.authoradoption.photoUrl)!) { (image) in
            
            self.userProfilePicture.image = image
        }
        
        
        //Address
        self.cityLabel.text = postsadoption?.cityadoption
        self.municipalityLabel.text = postsadoption?.municipalityadoption
        
        //Comments
        self.commentsTextView.text = postsadoption?.commentsadoption

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension  AdoptionSelectedViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    
}
