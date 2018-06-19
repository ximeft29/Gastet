//
//  HomeViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/4/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController{
    
    //VARS
 
    var queryusers = [String: String]()
    var usernames = [String]()
    

    //VAR ARRAYS - LOST
//    var userslost = [String: String]()
    var addresslost = [String]()
    var breedlost = [String]()
     var phonelost = [String]()
//    var usernameslost = [String]()
    var imageFileslost = [PFFile]()
    var refresherLost: UIRefreshControl = UIRefreshControl()
    
    //VAR ARRAYS - FOUND
//    var usersfound = [String: String]()
    var addressfound = [String]()
    var breedfound = [String]()
    var phonefound = [String]()
//    var usernamesfound = [String]()
    var imageFilesfound = [PFFile]()
    var refresherFound: UIRefreshControl = UIRefreshControl()
    
    //@IBOUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lostView: UIView!
    @IBOutlet weak var foundView: UIView!
    @IBOutlet weak var lostCollectionView: UICollectionView!
    @IBOutlet weak var foundCollectionView: UICollectionView!
    
 
    @objc func updateCollectionViewLost() {
        
        
        //FUNCTION QUERY FOR USERS
        
        let queryuserlost = PFUser.query()
        queryuserlost?.whereKey("username", notEqualTo: PFUser.current()?.username)
        queryuserlost?.findObjectsInBackground(block: { (objects, error) in

            if let users = objects {

                for object in users {

                    if let user = object as? PFUser {

                        self.queryusers[user.objectId!] = user.username!

                    }

                }

            }
        })
        
        
        
        //QUERY LOST
        
        let querylost = PFQuery(className: "Post")
        querylost.order(byDescending: "createdAt")
        querylost.whereKey("lostfound", equalTo: "lost")
        querylost.findObjectsInBackground { (objects, error) in
            
            if let posts = objects {
                
                for post in posts {


                    self.addresslost.append(post["address"] as! String)
                    
                    self.breedlost.append(post["breed"] as! String)
                    
                    self.phonelost.append(post["phone"] as! String)
                    
                    self.imageFileslost.append(post["imageFile"] as! PFFile)
                    
//                   self.usernames.append(self.queryusers[post["userid"] as! String]!)
                    
                    self.lostCollectionView.reloadData()
                    
                    self.refresherLost.endRefreshing()

                    
                }
            }
        }

        //TO SHOW DATA
        
        scrollView.delegate = self
        lostCollectionView.delegate = self
        lostCollectionView.dataSource = self

    }
    
    //FUNCTION QUERY FOUND
    
    @objc func updateCollectionViewFound() {
        
        // QUERY FOUND
        
        let queryfound = PFQuery(className: "Post")
        queryfound.whereKey("lostfound", equalTo: "found")
        queryfound.findObjectsInBackground { (objects, error) in
            
            if let posts = objects {
                
                for post in posts {
                    
                    self.addressfound.append(post["address"] as! String)
                    
                    self.breedfound.append(post["breed"] as! String)
                    
                    self.phonefound.append(post["phone"] as! String)
                   
//                    self.usernames.append(self.queryusers[post["userid"] as! String]!)

                    self.imageFilesfound.append(post["imageFile"] as! PFFile)
                    
                    self.foundCollectionView.reloadData()

                    self.refresherFound.endRefreshing()
                    
                }
                
            }
            
            
        }
        scrollView.delegate = self
        foundCollectionView.delegate = self
        foundCollectionView.dataSource = self
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateCollectionViewLost()
        updateCollectionViewFound()
        
        refresherLost.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refresherLost.addTarget(self, action: #selector(lostCollectionView.reloadData), for: UIControlEvents.valueChanged)
        lostCollectionView.addSubview(refresherLost)
        
        refresherFound.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refresherFound.addTarget(self, action: #selector(foundCollectionView.reloadData), for: UIControlEvents.valueChanged)
        foundCollectionView.addSubview(refresherFound)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// START OF EXTENSIONS FOR COLLECTION VIEWS

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.lostCollectionView {
            return addresslost.count
            //DUDA #2
        }
            
        else {
            return addressfound.count
            //DUDA #2
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.lostCollectionView {
          
            let cell: LostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Lostcell", for: indexPath) as! LostCollectionViewCell
            
            //TIENES QUE IGUALAR LOS @IBOUTLETS DEL CELL (SPECIFICOS A LOST) Y IGUALARLOS CON EL ARRAY DE PARSE QUE PUEDES ENCONTRAR EN VARS ARRIBA
            
            cell.adressLostLabel.text = addresslost[indexPath.row]
            cell.breedLostLabel.text = breedlost[indexPath.row]
            cell.phoneLostLabel.text = phonelost[indexPath.row]
//            cell.usernameLostLabel.text = usernames[indexPath.row]
            

            imageFileslost[indexPath.row].getDataInBackground { (data, error) in
                
                if let imageData = data {
                    
                    if let imageToDisplay = UIImage(data: imageData) {
                        
                         cell.postedImage.image = imageToDisplay
                        
                    }
                }
            }

            
            return cell
        }
        
        else {
            
            let cell: FoundCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Foundcell", for: indexPath) as! FoundCollectionViewCell
            
            cell.adressFoundLabel.text = addressfound[indexPath.row]
            cell.breedFoundLabel.text = breedfound[indexPath.row]
            cell.phoneFoundLabel.text = phonefound[indexPath.row]
//            cell.usernameFoundLabel.text = usernames[indexPath.row]
            
            imageFilesfound[indexPath.row].getDataInBackground { (data, error) in
                
                if let imageData = data {
                    
                    if let imageToDisplay = UIImage(data: imageData) {
                        
                        cell.postedImage.image = imageToDisplay
                        
                    }
                    
                }
                
            }

            return cell
        }

    }

}

//SCROLL

extension  HomeViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    
}

//DUDAS A RESOLVER
// 1 --> EN CELL --> ERROR IMAGEN
// 2 --> EN NUMBEROFITEMS -> ES RETURN _____.COUNT --> QUE PONGO AQUI?
// 3 --> HICE 2 QUERIES, SE PUEDE? SIRVE? , NO ENTENDI LO DE IF THEN
