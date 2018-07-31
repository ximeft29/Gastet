//
//  ProfileViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/30/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var currentUser = Auth.auth().currentUser

    //@IBOUTLETS

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    //@IBACTIONS
    
    @IBAction func editUserInformationButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "editUserInformation", sender: self)
    }
    
    //LOGOUT
    @IBAction func logoutButtonPressed(_ sender: UIButton) {

        print(Auth.auth().currentUser!)
       
        do {
            
            try Auth.auth().signOut()
            
        } catch let logoutError {
            print(logoutError)
        }
        
        print(Auth.auth().currentUser)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
        self.present(signUpVC , animated: true, completion: nil)
      
    }

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
        displayUserInformation()
    }
    
    func displayUserInformation() {
        
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.username.text! = (dictionary["username"] as? String)!
                self.email.text! = (dictionary["email"] as? String)!
            }
        }, withCancel: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 

}

