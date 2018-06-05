//
//  PostViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/9/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    //VARS
    
    var lost = Bool()
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var breed: UITextField!
    @IBOutlet weak var imagePosted: UIImageView!
    @IBOutlet weak var changeImageLostButton: UIButton!
    @IBOutlet weak var changeImageFoundButton: UIButton!
    
    
    //BUTTONS PRESSED - LOST & FOUND
    
    @IBAction func lostPressedButton(_ sender: UIButton) {
        
        changeImageLostButton.setImage(UIImage(named:"LostButton-active.png"), for: .normal)
        lost = true
    }
    

    
    @IBAction func foundPressedButton(_ sender: Any) {
        
        changeImageFoundButton.setImage(UIImage(named:"FoundButton-active.png"), for: .normal)
        lost = false
    }
    
    // ALERT
    
    func displayAlert(title:String, message:String) {
        
        //ALERT FOR WHEN NO TEXT IS ENTERED IN EMAIL AND PASSWORD FIELD
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //SPINNER
    
    
    //CODE TO CHOSE IMAGE
    
    @IBAction func choseImageButton(_ sender: UIButton) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imagePosted.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
   
    //PARSE CODE
    
    @IBAction func postButtonPressed(_ sender: Any) {
    
        if let image = imagePosted.image {
            
            let post = PFObject(className: "Post")
            post["address"] = address.text
            post["userid"] = PFUser.current()?.objectId
            post["breed"] = breed.text
            
          if lost {
              post["lostfound"] = "lost"
           } else {
              post["lostfound"] = "found"
          }
            
            if let imageData = UIImagePNGRepresentation(image) {
                
                //SPINNER
                
                let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                //END
                
                let imageFile = PFFile(name: "image.png", data: imageData)
                post["imageFile"] = imageFile
                post.saveInBackground { (success, error) in
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if success {
                        self.displayAlert(title: "Image Ha Sido Publicada", message: "Tu imagen ha sido publicada!")
                        self.address.text = ""
                        self.breed.text = ""
                        self.imagePosted.image = nil
                    } else {
                        self.displayAlert(title: "Imagen No Se Pudo Publicar", message: "Tu imagen no se pudo publicar. Trata más tarde.")
                    }
                }
            }
            
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
