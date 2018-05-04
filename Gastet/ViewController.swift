//
//  ViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 4/9/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate{

    var signupModeActive = true
    
    // ALERTAS - FUNC hecho para utilizar Alertas dependindo del caso
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
    
    @IBAction func signupOrLogin(_ sender: Any) {

        if email.text == "" || password.text == "" {
            
            displayAlert(title:"Error en forma", message:"Porfavor introduzca un email o una contraseña")
       
                                                    }
        else {
            
            //SPINNER PARA CUANDO SE ESTE CARGANDO COSAS
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
            
                
            print("Régistrandote....")
            
                    //Sacado del Signup Object Guide de iOS Parse Guides
                    let user = PFUser()
                    user.username = email.text
                    user.password = password.text
                    user.email = email.text
                    
                    user.signUpInBackground { (success, error) in
                     
                        //SPINNER
                        activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                        
                        if let error = error {
                            
                            //SOLVE 2 - MENSAJE SALE EN INGLES COMO LE HAGO PARA PONERLO EN ESPAÑOL
                            self.displayAlert(title: "No pudimos régistrate", message: error.localizedDescription)
                            
                            //let errorString = error.userInfo["error"] as? NSString
                            // Show the errorString somewhere and let the user try again.
                            
                            print(error)
                            
                        } else {
                            print("Has sigo régistrado!")
                            
                            // Hooray! Let them use the app now.
                        }
                    }
            }
        
    }
    
    @IBOutlet weak var signupOrLoginLabel: UILabel!
    
    @IBOutlet weak var switchLoginModeLabel: UILabel!
    
    @IBAction func switchLoginMode(_ sender: Any) {
        //BUTTON TO SWITCH FROM LOGIN TO SIGNUP MODE

        performSegue(withIdentifier: "toLoginViewController", sender: self)
    
    }
    
    @IBOutlet weak var switchLoginModeButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //PROBLEM 2 - SO THAT I CAN USE KEYBOARD DISMISSAL FUNCTIONS
        email.delegate = self
        password.delegate = self
        

        //PROBLEM 1 - LISTEN TO WHAT KEYBOARD IS SAYING
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)

    }
    
    deinit {
        //PROBLEM 1 - Stop Listening for keyboard to hide/show  events
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            self.performSegue(withIdentifier: "signupToHomeSegue", sender: self)
            
        }
    }
    
                                                //METHODS OR FUNCTIONS//
    

    //PROBLEM 2 - FUNC SO THAT WHEN YOU TOUCH OUTSIDE KEYBOARD IT WILL BE DISMISSED
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    //PROBLEM 2 - FUNC SO THAT KEYBOARD IS DISMISSED
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            textField.resignFirstResponder()
            
            // si quiero usar return para pasar al proximo text field usar el siguiente -- password.becomeFirstResponder()
            //password.becomeFirstResponder()
            
        } else if textField == password {
            textField.resignFirstResponder()
        }
        return true
    }
    
    //PROBLEM 2 - MOVE SCREEN SO KEYBOARD DOESN'T HIDE TEXTFIELD
    @objc func keyboardWillChange(notification: Notification) {

        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
    
        if notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame ||
            notification.name == Notification.Name.UIKeyboardDidChangeFrame {
            
            view.frame.origin.y =  -keyboardRect.height
            
        } else {
            //SOLVE 1 - TAKES TOO LONG TO RETURN TO ORIGINAL VIEW AND BLACK SPOT IS VIEWED
            
            view.frame.origin.y = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//PROBLEM 1 = Moving UITextfield View When the Keyboard Appears in Swift = because it covered textfield
//PROBLEM 2 = Hide Keyboard (Swift 4 + Xcode 9.0) = hiding keyboard

//SOLVE
// SOLVE 1 = When keyboard is returned to original view, you can see for a few seconds the black screen
//SOLVE 2 = Cuando un usuario que ya existe quiere volver a registrarse, la notificación aparece en ingles.

