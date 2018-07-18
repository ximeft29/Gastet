//
//  ProfileViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/30/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var currentUser = PFUser.current()

    //@IBOUTLETS

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    //@IBACTIONS
    
    @IBAction func editUserInformationButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "editUserInformation", sender: self)
    }
    
    //LOGOUT
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        PFUser.logOut()
        performSegue(withIdentifier: "logout", sender: self)
    }

    
    //EDIT PROFILE PICTURE - UPDATE #2
    
//    @IBAction func editProfilePictureButton(_ sender: UIButton) {
//
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        imagePicker.allowsEditing = false
//        self.present(imagePicker, animated: true, completion: nil)
//
//    }
//
//    // FUNCTIONS
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//
//            profilePictureImage.image = image
//
//            if self.currentUser != nil {
//
////                let imageData = UIImagePNGRepresentation(image)
////                let imageFile = PFFile(name:"profilepicture", data:imageData!)
////
//                self.currentUser?.saveInBackground(block: { (success, error) in
//
//                    self.dismiss(animated: true, completion: nil)
////                    profilePictureImage.image = currentUser?.profilepicture
////
//                    if success {
//                        self.displayAlert(title: "Imagen Ha Sido Guardada", message: "Tu imagen ha sido escogida y guardada exitosamente!")
//
//                    }
//                    else {
//                        self.displayAlert(title: "Error!", message: "Tu imagen no ha sido guardada!")
//                    }
//                })
//
//            }
//
//
//
//        }
//    }

    //ALERTS
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if currentUser != nil {
           
            username.text = currentUser?["username"] as? String
            email.text = currentUser?["email"] as? String
//            profilePictureImage.image = currentUser?["profilepicture"] as? UIImage
            
        }

        
      //Rounded Profile Image
//        profilePictureImage.layer.cornerRadius = profilePictureImage.frame.size.width/2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

