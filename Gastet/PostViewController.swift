//
//  PostViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/9/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var changeImageLostButton: UIButton!
    
    @IBAction func lostPressedButton(_ sender: UIButton) {
    
        changeImageLostButton.setImage(UIImage(named:"LostButton-active.png"), for: .normal)
    }
    
    @IBOutlet weak var changeImageFoundButton: UIButton!
    
    @IBAction func foundPressedButton(_ sender: UIButton) {
    
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
