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

class PostViewController: UIViewController, UIScrollViewDelegate{

    //VARS
    
    var lost = Bool()
    var selectedImage : UIImage!
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var breed: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var imagePosted: UIImageView!
    @IBOutlet weak var changeImageLostButton: UIButton!
    @IBOutlet weak var changeImageFoundButton: UIButton!

    //BUTTONS PRESSED - LOST & FOUND
    
    @IBAction func lostPressedButton(_ sender: UIButton) {
        changeImageFoundButton.setImage(UIImage(named:"FoundButton.png"), for: .normal)
        changeImageLostButton.setImage(UIImage(named:"LostButton-active.png"), for: .normal)
        lost = true
    }
    
    @IBAction func foundPressedButton(_ sender: Any) {
        changeImageFoundButton.setImage(UIImage(named:"FoundButton-active.png"), for: .normal)
        changeImageLostButton.setImage(UIImage(named:"LostButton.png"), for: .normal)
        lost = false
    }
    
    //FIREBASE CODE
    
    @IBAction func postButtonPressed(_ sender: Any) {
        
        
        ProgressHUD.show("En Proceso...")
        let storage = Storage.storage()
        let storageRef = storage.reference()
        //photo idstring gives us a unique string for any given time of the day. Garantied unique string
        let photoIdString = "\(NSUUID().uuidString).jpg"
        let imageReference = storageRef.child("posts").child(photoIdString)
        if let imageData = UIImageJPEGRepresentation(selectedImage, 0.7) {
            imageReference.putData(imageData).observe(.success) { (snapshot) in
            imageReference.downloadURL(completion: { (url, error) in
                
                let timestampSince = NSDate().timeIntervalSince1970
                let timestamp = snapshot.metadata?.timeCreated
                let stringTimestamp = timestamp?.toString(dateFormat: "dd-MM-yyyy'T'HH:mm:ss.SSSZ")
                if let downloadUrl = url {
                    let directoryURL : NSURL = downloadUrl as NSURL
                    let urlString:String = directoryURL.absoluteString!
                    if self.lost {
    
                        self.sendDataToDatabaseLost(address: self.address.text!, breed: self.breed.text!, phone: self.phone.text!, photoUrl: urlString, timestamp: timestampSince)
                        
                    }
                        
                    else {
                        
                        self.sendDataToDatabaseFound(address: self.address.text!, breed: self.breed.text!, phone: self.phone.text!, photoUrl: urlString, timestamp: stringTimestamp!)
                    }
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
    
    func sendDataToDatabaseLost(address: String, breed: String, phone: String, photoUrl: String, timestamp: Double) {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let postsReference = ref.child("posts").child("lost")
        let newPostId = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostId)
        //current user information
        let toId = Auth.auth().currentUser?.uid
        newPostReference.setValue( ["address": address, "breed": breed, "phone": phone,"photoUrl": photoUrl, "timestamp": timestamp, "author": ["userid": toId, "username": UserService.currentUserProfile?.username, "profilePhotoUrl": UserService.currentUserProfile?.photoUrl.absoluteString]]) { (error, ref) in

            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }

            ProgressHUD.showSuccess("Tu imagen ha sido publicada!")
            self.address.text = ""
            self.breed.text = ""
            self.phone.text = ""
            self.imagePosted.image = UIImage(named: "placeholder.png")
            self.changeImageLostButton.setImage(UIImage(named:"LostButton.png"), for: .normal)
            self.changeImageFoundButton.setImage(UIImage(named:"FoundButton.png"), for: .normal)
            //TO HOME VIEW CONTROLLER
            self.tabBarController?.selectedIndex = 0
        }

    }
    
    func sendDataToDatabaseFound(address: String, breed: String, phone: String, photoUrl: String, timestamp: String) {
        //por the time being photoUrl:String - wasn't added because I can't get the downloadURL
        //         func sendDataToDatabase(address: String, breed: String, phone: String, lostfound: String, photoUrl: String)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let postsReference = ref.child("posts").child("found")
        let newPostId = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostId)
        // Still need to add the "photo": photoUrl --> newPostReference.setValue(["photoUrl": photoUrl]
        let toId = Auth.auth().currentUser?.uid
        newPostReference.setValue( ["address": address, "breed": breed, "phone": phone,"photoUrl": photoUrl, "timestamp": timestamp, "author": ["userid": toId, "username": UserService.currentUserProfile?.username, "profilePhotoUrl": UserService.currentUserProfile?.photoUrl.absoluteString]]) { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Tu imagen ha sido publicada!")
            self.address.text = ""
            self.breed.text = ""
            self.phone.text = ""
            self.imagePosted.image = UIImage(named: "placeholder.png")
            self.changeImageLostButton.setImage(UIImage(named:"LostButton.png"), for: .normal)
            self.changeImageFoundButton.setImage(UIImage(named:"FoundButton.png"), for: .normal)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        imagePosted.addGestureRecognizer(tapGesture)
        imagePosted.isUserInteractionEnabled = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        self.dismiss(animated: true, completion: nil)
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



