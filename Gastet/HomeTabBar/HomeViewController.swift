//
//  HomeViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/4/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController{
    
//    VARS
    var posts = [Posts]()
    var postsfound = [PostsFound]()
    
    //REFRESHERS
    var refresherLost: UIRefreshControl = UIRefreshControl()
    var refresherFound: UIRefreshControl = UIRefreshControl()
    
    //@IBOUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lostView: UIView!
    @IBOutlet weak var foundView: UIView!
    @IBOutlet weak var lostCollectionView: UICollectionView!
    @IBOutlet weak var foundCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LOST  UPDATE COLLECTIONVIEW
        scrollView.delegate = self
        lostCollectionView.delegate = self
        lostCollectionView.dataSource = self
        
        //FOUND UPDATE COLLECTIONVIEW
        scrollView.delegate = self
        foundCollectionView.delegate = self
        foundCollectionView.dataSource = self
        
        observePostsLost()
        observePostsFound()

        //Refresher
        refresherLost.addTarget(self, action: #selector(lostCollectionView.reloadData), for: UIControlEvents.valueChanged)
        lostCollectionView.addSubview(refresherLost)
        
        refresherFound.addTarget(self, action: #selector(foundCollectionView.reloadData), for: UIControlEvents.valueChanged)
        foundCollectionView.addSubview(refresherLost)
    }
    
    @objc func observePostsLost() {
        let postsRef = Database.database().reference().child("posts").child("lost")
        postsRef.queryOrdered(byChild: "timestamp").observe(.value) { (snapshot) in
         
                        var tempPost = [Posts]()
            
                        for child in snapshot.children {
                            if let childSnapshot = child as? DataSnapshot {
            
                                let dict = childSnapshot.value as? [String: Any]
                                let address = dict!["address"] as? String
                                let breed = dict!["breed"] as? String
                                let phoneuser = dict!["phone"] as? String
                                let photoUrl = dict!["photoUrl"] as? String
                                let url = URL(string: photoUrl!)
                                let post = Posts(address: address!, breed: breed!, phone: phoneuser!, photoUrl: url!)
                                tempPost.insert(post, at: 0)
                            }
            
                            self.posts = tempPost
                            
                            self.lostCollectionView.reloadData()
                            self.refresherLost.endRefreshing()
            
        }
    }
    }

    @objc func observePostsFound() {
        let postsRef = Database.database().reference().child("posts").child("found")
        postsRef.queryOrdered(byChild: "timestamp").observe(.value) { (snapshot) in
            
            var tempPost = [PostsFound]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    
                    let dict = childSnapshot.value as? [String: Any]
                    let addressfound = dict!["address"] as? String
                    let breedfound = dict!["breed"] as? String
                    let phoneuserfound = dict!["phone"] as? String
                    let photoUrlfound = dict!["photoUrl"] as? String
                    let url = URL(string: photoUrlfound!)
                    let post = PostsFound(addressfound: addressfound!, breedfound: breedfound!, phonefound: phoneuserfound!, photoUrlfound: url!)
                    tempPost.insert(post, at: 0)
                }
                
                self.postsfound = tempPost
                self.foundCollectionView.reloadData()
                self.refresherFound.endRefreshing()
            }
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//// START OF EXTENSIONS FOR COLLECTION VIEWS
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.lostCollectionView {

            return posts.count
        }
            
        else {
            return postsfound.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.lostCollectionView {
            
            let cell: LostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Lostcell", for: indexPath) as! LostCollectionViewCell

            cell.set(post: posts[indexPath.row])
            

            //Make TextView Clickable
            cell.phoneLostTextView.isEditable = false;
            cell.phoneLostTextView.dataDetectorTypes = UIDataDetectorTypes.phoneNumber
            
            
            return cell
            
                                                    }
        else {
            
            let cell: FoundCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Foundcell", for: indexPath) as! FoundCollectionViewCell
            
            cell.set(postfound: postsfound[indexPath.row])
            
            //Make TextView Clickable
            cell.phoneFoundTextView.isEditable = false;
            cell.phoneFoundTextView.dataDetectorTypes = UIDataDetectorTypes.phoneNumber            
            
            return cell
            
                }
        }
}

////SCROLL

extension  HomeViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    
}

