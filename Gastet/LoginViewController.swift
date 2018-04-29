//
//  LoginViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 4/26/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    //ALERT
    
    func displayAlert(title:String, message:String) {
        
        //ALERT FOR WHEN NO TEXT IS ENTERED IN EMAIL AND PASSWORD FIELD
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet var panToClose: InteractionPanToClose!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
       
        PFUser.logInWithUsername(inBackground: email.text!, password: password.text!) { (user, error) in
       
        //AGREGA AQUI SPINNER - CHECA EN CURSO UDEMY
            
        //UIApplication.shared.endIgnoringInteractionEvents()
            
            // aqui esta error
            
            if user != nil {
                print("Ha iniciado seción exitosamente")
            }
            else {
                
                var errorText = "Error desconocido: porfavor intente de nuevo"
                
                if let error = error {
                    
                    errorText = error.localizedDescription
                }
                self.displayAlert(title: "No hemos podido iniciar seción", message: errorText)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        panToClose.setGestureRecognizer()
        
        // Do any additional setup after loading the view.
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
