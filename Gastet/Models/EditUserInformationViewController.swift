//
//  EditUserInformationViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 6/11/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditUserInformationViewController: UIViewController {

    var databaseRef: DatabaseReference!
    
    
    //@IBOUTLETS
    @IBOutlet weak var userTextField: UITextField!

    //@IBACTIONS
    
    @IBAction func saveInformationButton(_ sender: UIButton) {
        
        ProgressHUD.show("En Proceso...")
        //1. First you need to check that the user is logged in
        if let userId = Auth.auth().currentUser?.uid {
            //2. you create a new let statement to change the infomation
            guard let newUserName = self.userTextField.text else {return}
            
            //3. now you need to create a new dictionary in order to write it back to the firebase dictionary
            let newValuesForProfile =  ["username": newUserName]
            
            //4. update firebase data for user
            self.databaseRef.child("users").child(userId).updateChildValues(newValuesForProfile) { (error, ref) in
                if error != nil {
                   ProgressHUD.showError("Ha habido un error. Intenta más tarde.")
                    print(error)
                    return
                }
                ProgressHUD.showSuccess("Tu perfil se ha editado!")
                //5. perform segue
                self.dismiss(animated: true, completion: {
                    self.tabBarController?.selectedIndex = 1
                })
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
