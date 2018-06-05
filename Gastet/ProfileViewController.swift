//
//  ProfileViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/30/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    var currentUser = PFUser.current()

    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBAction func logoutButton(_ sender: UIButton) {
    
        PFUser.logOut()
        performSegue(withIdentifier: "logout", sender: self)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if currentUser != nil {
           
            username.text = currentUser?["username"] as? String
            email.text = currentUser?["email"] as? String
            
            
        }

        
      //Rounded Profile Image
        profilePictureImage.layer.cornerRadius = profilePictureImage.frame.size.width/2
        
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
