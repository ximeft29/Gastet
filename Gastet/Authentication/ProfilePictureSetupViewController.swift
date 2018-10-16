//
//  ProfilePictureSetupViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 6/1/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfilePictureSetupViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //VARS
    var selectedProfileImage : UIImage!
    
    //IBOUTLETS
    
    @IBOutlet weak var profilePictureImage: UIImageView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    //IBACTIONS
    @IBAction func choseImageButton(_ sender: UIButton) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
            
            ProgressHUD.show("En Proceso...")
            let storage = Storage.storage()
            let storageRef = storage.reference()
            //photo idstring gives us a unique string for any given time of the day. Garantied unique string
            let photoIdString = "\(NSUUID().uuidString).jpg"
            let imageReference = storageRef.child("profileImages").child(photoIdString)
            if let imageData = UIImageJPEGRepresentation(selectedProfileImage, 0.4) {
                imageReference.putData(imageData).observe(.success) { (snapshot) in
                    imageReference.downloadURL(completion: { (url, error) in
                        
                        if let downloadUrl = url {
                            let directoryURL : NSURL = downloadUrl as NSURL
                            let urlString:String = directoryURL.absoluteString!
                            self.sendDataToUserDatabase(photoUrl: urlString)
                                ProgressHUD.showSuccess("Tu imagen ha sido publicada!")
                        }
                        else {
                            print("couldn't get profile image url")
                            ProgressHUD.showError("No hemos podido subir tu foto de perfil. Intenta más tarde")
                            return
                        }
                    })
                }
        }

    }
    
    //FUNCS
    
    func sendDataToUserDatabase(photoUrl: String) {
        //por the time being photoUrl:String - wasn't added because I can't get the downloadURL

                var ref: DatabaseReference!
                ref = Database.database().reference()
                let usersReference = ref.child("users")
                let uid = Auth.auth().currentUser?.uid
                let newUserReference = usersReference.child(uid!)
                newUserReference.updateChildValues(["photoUrl": photoUrl]) { (error, ref) in
                    if error != nil {
                        ProgressHUD.showError(error!.localizedDescription)
                        return
                    }
                    ProgressHUD.showSuccess("Tu imagen ha sido publicada!")
                    self.performSegue(withIdentifier: "toHomeVC", sender: self)
                }
        

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        print("did Finish Picking Media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedProfileImage = image
            profilePictureImage.image = image
            
        }
        
        self.dismiss(animated: true, completion: {
            self.finishButton.isHidden = false
            
        })
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
        profilePictureImage.addGestureRecognizer(tapGesture)
        profilePictureImage.isUserInteractionEnabled = true
        finishButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
