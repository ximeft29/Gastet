//
//  ChoseUsernameViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 4/28/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class ChoseUsernameViewController: UIViewController {
    
  

    //@IBOUTLET
    
    @IBOutlet weak var userTextField: UITextField!
    
    //FUNCTION ALERT
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //@IBACTION - NEED TO PUT IF LET STATEMENTS FOR WHEN USERNAME IS TAKEN
    
    @IBAction func nextTapButton(_ sender: Any) {
 
        let currentUser = PFUser.current()!
        let username = userTextField.text
        currentUser["username"] = username
        currentUser.saveInBackground()
            
        performSegue(withIdentifier: "toHome", sender: self)
        
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}
