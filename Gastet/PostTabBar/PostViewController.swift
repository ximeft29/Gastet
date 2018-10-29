//
//  PostViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/9/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

enum PostCategory: String {
    case lost = "lost"
    case found = "found"
    case adopt = "adopt"
}

enum PetKind: String {
    case dog
    case cat
    case other
}

enum Gender: String {
    case male, female
}

class PostViewController: UIViewController, UITextViewDelegate{
 
    //VARS
    var lost = Bool()
    var selectedImage : UIImage!
    
    
    var selectedPostCategory: PostCategory?
    var selectedPet: PetKind?
    var selectedGender: Gender?
    
    //@IBOUTLETS
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagePosted: UIImageView!
    
    //postType View
    @IBOutlet weak var changeImageLostButton: UIButton!
    @IBOutlet weak var changeImageFoundButton: UIButton!
    @IBOutlet weak var changeImageAdoptButton: UIButton!
    @IBOutlet weak var otherPetStackView: UIStackView!
    
    
    //petType View
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet weak var otherPetButton: UIButton!
    
    //name textfield
    

    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var petNameTextField: UITextField!
    
    //gender View
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    //breed View
    @IBOutlet weak var breed: UITextField!
    
    //city View
    @IBOutlet weak var cityButton: UIButton!
    
    //municipios View
    @IBOutlet weak var muncipalityButton: UIButton!
    
    //address View
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var address: UITextField!
    
    //phone View
    @IBOutlet weak var phone: UITextField!
    
    //comments
    @IBOutlet weak var commentsTextView: UITextView!
    

    //post whole ad
    @IBOutlet weak var postButton: UIButton!
    
    //BUTTONS PRESSED - LOST & FOUND
    
    @IBAction func lostPressedButton(_ sender: UIButton) {
        selectedPostCategory = .lost
        changeImageLostButton.setImage(UIImage(named:"icon_lost_active.png"), for: .normal)
        changeImageFoundButton.setImage(UIImage(named:"icon_found_inactive.png"), for: .normal)
        changeImageAdoptButton.setImage(UIImage(named: "icon_adoption_inactive.png"), for: .normal)
        lost = true
        otherPetStackView.isHidden = false
        nameView.isHidden = false
        addressView.isHidden = false
        enablePostButton()
    }
    
    @IBAction func foundPressedButton(_ sender: Any) {
        selectedPostCategory = .found
        changeImageLostButton.setImage(UIImage(named:"icon_lost_inactive.png"), for: .normal)
        changeImageFoundButton.setImage(UIImage(named:"icon_found_active.png"), for: .normal)
        changeImageAdoptButton.setImage(UIImage(named: "icon_adoption_inactive.png"), for: .normal)
        lost = false
        otherPetStackView.isHidden = false
        nameView.isHidden = true
        addressView.isHidden = false
        enablePostButton()
    }
    
    @IBAction func adoptPressedButton(_ sender: UIButton) {
        selectedPostCategory = .adopt
        changeImageLostButton.setImage(UIImage(named:"icon_lost_inactive.png"), for: .normal)
        changeImageFoundButton.setImage(UIImage(named:"icon_found_inactive.png"), for: .normal)
        changeImageAdoptButton.setImage(UIImage(named: "icon_adoption_active.png"), for: .normal)
        otherPetStackView.isHidden = true
        nameView.isHidden = true
        addressView.isHidden = true
        enablePostButton()
    
    }
    
    //@IBACTIONS - petType
    
    
    @IBAction func dogPressedButton(_ sender: UIButton) {
        selectedPet = .dog
        dogButton.setImage(UIImage(named: "icon_dog_active.png"), for: .normal)
        catButton.setImage(UIImage(named: "icon_cat_inactive.png"), for: .normal)
        otherPetButton.setImage(UIImage(named: "icon_otherpet_inactive.png"), for: .normal)
        enablePostButton()
    }
    
    @IBAction func catPressedButton(_ sender: UIButton) {
         selectedPet = .cat
        dogButton.setImage(UIImage(named: "icon_dog_inactive.png"), for: .normal)
          catButton.setImage(UIImage(named: "icon_cat_active.png"), for: .normal)
          otherPetButton.setImage(UIImage(named: "icon_otherpet_inactive.png"), for: .normal)
        enablePostButton()
    }

    @IBAction func otherPetPressedButton(_ sender: UIButton) {
         selectedPet = .other
        dogButton.setImage(UIImage(named: "icon_dog_inactive.png"), for: .normal)
          catButton.setImage(UIImage(named: "icon_cat_inactive.png"), for: .normal)
          otherPetButton.setImage(UIImage(named: "icon_otherpet_active.png"), for: .normal)
        enablePostButton()
    }
    
    //@IBACTIONS - gender
    
    @IBAction func maleButtonPressed(_ sender: UIButton) {
        selectedGender = .male
        maleButton.setImage(UIImage(named: "icon_male_active.png"), for: .normal)
        femaleButton.setImage(UIImage(named: "icon_female_inactive.png"), for: .normal)
        enablePostButton()
    }
    
    @IBAction func femaleButtonPressed(_ sender: UIButton) {
        selectedGender = .female
        maleButton.setImage(UIImage(named: "icon_male_inactive.png"), for: .normal)
        femaleButton.setImage(UIImage(named: "icon_female_active.png"), for: .normal)
        enablePostButton()
    }
    
    
    //IBActions - City
    
    @IBAction func cityButtonPressed(_ sender: UIButton) {
        enablePostButton()
    }
    
    @IBAction func municipalityButtonPressed(_ sender: UIButton) {
        
        enablePostButton()
    }
    
    //IBAction - textFieldEditing for enable Button
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
   
    enablePostButton()
        
    }
    
    
    
    //FIREBASE CODE
    
    @IBAction func postButtonPressed(_ sender: Any) {
       


            postButton.setTitle("Publicar", for: .normal)
            postButton.isHidden = false
            ProgressHUD.show("En Proceso...")
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            //photo idstring gives us a unique string for any given time of the day. Garantied unique string
            let photoIdString = "\(NSUUID().uuidString).jpg"
            let imageReference = storageRef.child("posts").child(photoIdString)
            if let imageData = UIImageJPEGRepresentation(selectedImage, 0.4) {
                imageReference.putData(imageData).observe(.success) { (snapshot) in
                    imageReference.downloadURL(completion: { (url, error) in
                        
                        
                        if let downloadUrl = url {
                            let directoryURL : NSURL = downloadUrl as NSURL
                            let urlString:String = directoryURL.absoluteString!
                            let toId = Auth.auth().currentUser?.uid
                            var dataToSend: [String: Any]
                            switch self.selectedPostCategory! {
                            case .lost:
                                dataToSend = [
                                    
                                    "author": [
                                        "userid": toId,
                                        "username": UserService.currentUserProfile?.username,
                                        "profilePhotoUrl": UserService.currentUserProfile?.photoUrl.absoluteString
                                    ],
                                    "photoUrl": urlString,
                                    "postType": self.selectedPostCategory!.rawValue,
                                    "petType": self.selectedPet!.rawValue,
                                    "name": self.nameTextField.text!,
                                    "gender": self.selectedGender!.rawValue,
                                    "breed": self.breed.text!,
                                    "city" : self.cityButton.currentTitle! ,
                                    "municipality": self.muncipalityButton.currentTitle! ,
                                    "address": self.address.text!,
                                    "phone": self.phone.text!,
                                    "timestamp": ServerValue.timestamp(),
                                    "comments": self.commentsTextView.text!
                                ]
                                
                                break
                                
                            case .found:
                                dataToSend = [
                                    
                                    "author": [
                                        "userid": toId,
                                        "username": UserService.currentUserProfile?.username,
                                        "profilePhotoUrl": UserService.currentUserProfile?.photoUrl.absoluteString
                                    ],
                                    "photoUrl": urlString,
                                    "postType": self.selectedPostCategory!.rawValue,
                                    "petType": self.selectedPet!.rawValue,
                                    "gender": self.selectedGender!.rawValue,
                                    "breed": self.breed.text!,
                                    "city" : self.cityButton.currentTitle! ,
                                    "municipality": self.muncipalityButton.currentTitle! ,
                                    "address": self.address.text!,
                                    "phone": self.phone.text!,
                                    "timestamp": ServerValue.timestamp(),
                                    "comments": self.commentsTextView.text!
                                ]
                                break
                                
                            case .adopt:
                                dataToSend = [
                                    
                                    "author": [
                                        "userid": toId,
                                        "username": UserService.currentUserProfile?.username,
                                        "profilePhotoUrl": UserService.currentUserProfile?.photoUrl.absoluteString
                                    ],
                                    "photoUrl": urlString,
                                    "postType": self.selectedPostCategory!.rawValue,
                                    "petType": self.selectedPet!.rawValue,
                                    "gender": self.selectedGender!.rawValue,
                                    "breed": self.breed.text!,
                                    "city" : self.cityButton.currentTitle! ,
                                    "municipality": self.muncipalityButton.currentTitle! ,
                                    "phone": self.phone.text!,
                                    "timestamp": ServerValue.timestamp(),
                                    "comments": self.commentsTextView.text!
                                ]
                                break
                                
                            }
                            
                            self.sendDataToDatabase(data: dataToSend)
                        }
                        else {
                            ProgressHUD.showError("No has escogido una imagen")
                            print("couldn't get profile image url")
                            return
                        }
                    })
                }
            }
            else {
                ProgressHUD.showError("Tienes que subir una foto...")
            }
            
        
        

    }
    
// FUNCTION - ALERT

    func sendDataToDatabase(data:[String: Any]) {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostId)
        //current user information
        newPostReference.setValue(data) { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            ProgressHUD.showSuccess("Tu imagen ha sido publicada!")
            
            //set to empty fields
            self.imagePosted.image = UIImage(named: "placeholder.png")
            self.changeImageLostButton.setImage(UIImage(named:"icon_lost_inactive.png"), for: .normal)
            self.changeImageFoundButton.setImage(UIImage(named:"icon_found_inactive.png"), for: .normal)
            self.changeImageAdoptButton.setImage(UIImage(named: "icon_adoption_inactive.png"), for: .normal)
            self.dogButton.setImage(UIImage(named: "icon_dog_inactive.png"), for: .normal)
            self.catButton.setImage(UIImage(named: "icon_cat_inactive.png"), for: .normal)
            self.otherPetButton.setImage(UIImage(named: "icon_otherpet_inactive.png"), for: .normal)
            self.maleButton.setImage(UIImage(named: "icon_male_inactive.png"), for: .normal)
            self.femaleButton.setImage(UIImage(named: "icon_female_inactive.png"), for: .normal)
            self.nameTextField.text = ""
            self.cityButton.setTitle("Cuidad", for: .normal)
            self.cityButton.setTitleColor(UIColor.lightGray, for: .normal)
            self.muncipalityButton.setTitle("Municipio", for: .normal)
            self.muncipalityButton.setTitleColor(UIColor.gray, for: .normal)
            self.address.text = ""
            self.breed.text = ""
            self.phone.text = ""
            self.commentsTextView.text = ""
            
            //TO HOME VIEW CONTROLLER
            self.tabBarController?.selectedIndex = 0
        }
    }

    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //FUNCTIONS - to Hide button until information is inputed
    
    func enablePostButton() {
        
        var hideButton = false
        
        if selectedPostCategory == nil {
            hideButton = true
        }
        
        if selectedGender == nil {
            hideButton = true
        }
        
        if selectedPet == nil {
            hideButton = true
        }
        
        
        if selectedPostCategory == .lost, (address.text?.count)!  < 1 {
            hideButton = true
        }
        
        if selectedPostCategory == .found, (address.text?.count)!  < 1 {
            hideButton = true
        }
        
        if breed.text!.count < 1 {
            hideButton = true
        }
        
        if phone.text!.count < 1 {
            hideButton = true
        }
        
        if commentsTextView.text!.count < 1 {
               hideButton = true
        }
        
        if cityButton.currentTitle! == "Cuidad" {
               hideButton = true
        }
        
        if muncipalityButton.currentTitle! == "Municipio" {
            hideButton = true
        }
        
        if selectedPostCategory == .lost, (nameTextField.text?.count)!  < 1 {
            hideButton = true
        }

        postButton.isHidden = hideButton

    }

    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
    }
    
    
    func commentsTextViewIsEdited() {
        
        
        if commentsTextView.text! != "Commentarios Adicinales"   {
            commentsTextView.text = ""
            commentsTextView.textColor = UIColor.black
            
        }
        
        else {
            commentsTextView.textColor = UIColor.lightGray
        }
    }
    
    
    
    //prepare segue for city Selection - this will help bring information from another ViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "citySelection":
            if let destinationViewController = segue.destination as? CitiesViewController {
                destinationViewController.selectCityHandler = { city in
                    self.cityButton.setTitle(city, for: .normal)
                    self.cityButton.setTitleColor(UIColor.black, for: .normal)
                    print(city)
                }
            }
            break
            
        case  "municipalitySelection":
            if let destinationViewController = segue.destination as? MunicipalityViewController {
                destinationViewController.selectMunicipalityHandler = {municipality in
                    self.muncipalityButton.setTitle(municipality, for: .normal)
                    self.muncipalityButton.setTitleColor(UIColor.black, for: .normal)
                    print(municipality)
                }
            }
            break
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tappable image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        imagePosted.addGestureRecognizer(tapGesture)
        imagePosted.isUserInteractionEnabled = true
        
        
        self.view.backgroundColor = UIColor.white
        scrollView.delegate = self
        
        commentsTextView.delegate = self
        
        enablePostButton()
        commentsTextViewIsEdited()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentsTextView.text = ""
        commentsTextView.textColor? = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        enablePostButton()
    }
}

//EXTENSION

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    
    {
        print("did Finish Picking Media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            imagePosted.image = image
        }
        
        else {
            
            postButton.isHidden = true
            
        }
        
        
        self.dismiss(animated: true) {
            self.enablePostButton()
        }
        
    }
}

extension Date {
    
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

extension  PostViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    
}
