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
    
    //@IBACTION
    @IBAction func nextTapButton(_ sender: Any) {
    
         let username = userTextField.text
//          var currentUser = PFUser.current()
        
        var currentUser = PFUser.current()!
        currentUser["username"] = username
        currentUser.saveInBackground()
        
//        if currentUser != nil {
//
//            currentUser?.username = userTextField.text!
            // currentUser?.username = userTextField.text!
            //you have to do a do,try catch
//            do {
//
//            try currentUser?.save()
//
//            }
//            //if that try fails you go to the catch
//
//            catch {
//
//                 self.displayAlert(title: "No hemos podido asignarte ese usuario", message: error.localizedDescription)
//
//            }
            
            performSegue(withIdentifier: "toHome", sender: self)
        
//        }
        
//        else {
//
//            self.displayAlert(title: "No hemos podido asignarte ese usuario", message: "No se pudo guardar el usuario.")
//
//            }
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
