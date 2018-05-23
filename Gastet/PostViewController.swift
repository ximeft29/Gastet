//
//  PostViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/9/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet weak var imagePosted: UIImageView!
    
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
    
    @IBOutlet weak var changeImageLostButton: UIButton!
    
    @IBAction func lostPressedButton(_ sender: UIButton) {
    
    changeImageLostButton.setImage(UIImage(named:"LostButton-active.png"), for: .normal)
    }
    
    @IBOutlet weak var changeImageFoundButton: UIButton!
    
    @IBAction func foundPressedButton(_ sender: Any) {
    
        changeImageFoundButton.setImage(UIImage(named:"FoundButton-active.png"), for: .normal)
        
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
