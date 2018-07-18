//
//  EditUserInformationViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 6/11/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class EditUserInformationViewController: UIViewController {

    var currentUser = PFUser.current()
    
    //@IBOUTLETS
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    //@IBACTIONS
    
    @IBAction func saveInformationButton(_ sender: UIButton) {
    
        if currentUser != nil {
            
            currentUser?.username = userTextField.text!
            currentUser?.email = emailTextField.text!
           
            //you have to do a do,try catch
            
            do {

                try currentUser?.save()
                
            }
                //if that try fails you go to the catch
            catch {
                
                self.displayAlert(title: "No hemos podido modificar tu información", message: error.localizedDescription)
                
            }
            
            performSegue(withIdentifier: "backToUserProfile", sender: self)

        }
            
        else {
            
            self.displayAlert(title: "No hemos podido modificar tu información", message: "No se pudo guardar cambio.")
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTextField.text = currentUser?.username
        emailTextField.text = currentUser?.email
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //FUNCTIONS
    
    func fetchVenuesFromParse() {
        
        if currentUser != nil {
            
            self.userTextField.text = currentUser?["username"] as? String
            self.emailTextField.text = currentUser?["email"] as? String
            
        }
        
    }
    
    //ALERT
    func displayAlert(title:String, message:String) {
        

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
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
