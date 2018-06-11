//
//  EditUsernameViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 6/8/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class EditUsernameViewController: UIViewController {

    var currentuser = PFUser.current()
    
    
    //ALERT FUNCTION
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //@IBOUTLETS
    
    @IBOutlet weak var username: UITextField!
    
    
    //@IBACTION
    
    @IBAction func saveUsernameButton(_ sender: UIButton) {
        
        if currentuser != nil {
            
            currentuser?.username = username.text!
            
            do {
                
                try currentuser?.save()
                
            }
            
            catch {
                
                        self.displayAlert(title: "No hemos podido asignarte ese usuario", message: error.localizedDescription)
                
            }
            
            performSegue(withIdentifier: "backToProfileUsername", sender: self)
        }
        
        else {
            
             self.displayAlert(title: "No hemos podido asignarte ese usuario", message: "No se pudo guardar el usuario.")
            
        }
        
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
