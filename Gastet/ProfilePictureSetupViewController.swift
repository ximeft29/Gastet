//
//  ProfilePictureSetupViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 6/1/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class ProfilePictureSetupViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var  currentuser = PFUser.current()
    
    // ALERTAS - FUNC hecho para utilizar Alertas dependindo del caso
    
    func displayAlert(title:String, message:String) {
        
        //ALERT FOR WHEN NO TEXT IS ENTERED IN EMAIL AND PASSWORD FIELD
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //IBOUTLETS
    
    @IBOutlet weak var profilePictureImage: UIImageView!
    
    @IBAction func choseImageButton(_ sender: UIButton) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profilePictureImage.image = image
        }
        
        dismiss(animated: true, completion:  nil)
        
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        
        if currentuser != nil {
            
            if let image = profilePictureImage.image {
                
                let imageData = UIImagePNGRepresentation(image)
                let imageFile = PFFile(name:"profilePicture", data:imageData!)
                currentuser?.saveInBackground(block: { (success, error) in
                    if success {
                        self.displayAlert(title: "Imagen Ha Sido Guardada", message: "Tu imagen ha sido escogida y guardada exitosamente!")
                    }
                    else {
                        self.displayAlert(title: "Error!", message: "Tu imagen no ha sido guardada!")
                    }
                })
                
            }
            
        }
        
            //PORQUE NO PUEDO PONER LOCALIZED ERROR?
        else {
            displayAlert(title: "Error", message: "Ha habido un error. Intente más tarde")
        }
     
    performSegue(withIdentifier: "toHome", sender: self)
    
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
