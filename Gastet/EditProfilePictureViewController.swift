//
//  EditProfilePictureViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 6/8/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class EditProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

     var  currentuser = PFUser.current()
    
    
    func displayAlert(title:String, message:String) {
        
        //ALERT FOR WHEN NO TEXT IS ENTERED IN EMAIL AND PASSWORD FIELD
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var newProfilePictureImageView: UIImageView!
    
    @IBAction func choseNewPictureButton(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            newProfilePictureImageView.image = image
        }
        
        dismiss(animated: true, completion:  nil)
        
    }
    
    
    @IBAction func savePicture(_ sender: UIButton) {
        
        if currentuser != nil {
            
            if let image = newProfilePictureImageView.image {
                
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
            
            else {
                
                self.displayAlert(title: "Error!", message: "Ha habido un error. Intente más tarde")
            }
           
            performSegue(withIdentifier: "backToProfilePicture", sender: self)
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
