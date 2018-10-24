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
    
    //VARS
    var posts = [Posts]()
    var postsfound = [PostsFound]()
    var postsadoption = [PostsAdoption]()
    
    //REFRESHERS
    var refresherLost: UIRefreshControl = UIRefreshControl()
    var refresherFound: UIRefreshControl = UIRefreshControl()
    var refresherAdoption: UIRefreshControl = UIRefreshControl()
    
    //@IBOUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lostView: UIView!
    @IBOutlet weak var foundView: UIView!
    @IBOutlet weak var adoptionView: UIView!
    
    @IBOutlet weak var lostCollectionView: UICollectionView!
    @IBOutlet weak var foundCollectionView: UICollectionView!
    @IBOutlet weak var adoptionCollectionView: UICollectionView!
    
    
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
        
        //ADOPTION UPDATE COLLECTIONVIEW
        scrollView.delegate = self
        adoptionCollectionView.delegate = self
        adoptionCollectionView.dataSource = self
        
        observePostsLost()
        observePostsFound()
        observePostsAdoption()
        
        //Refresher
        refresherLost.addTarget(self, action: #selector(lostCollectionView.reloadData), for: UIControlEvents.valueChanged)
        lostCollectionView.addSubview(refresherLost)
        
        refresherFound.addTarget(self, action: #selector(foundCollectionView.reloadData), for: UIControlEvents.valueChanged)
        foundCollectionView.addSubview(refresherLost)
        
        refresherAdoption.addTarget(self, action: #selector(adoptionCollectionView.reloadData), for: UIControlEvents.valueChanged)
        adoptionCollectionView.addSubview(refresherLost)

    }
    
    
    @objc func observePostsLost() {
        let postsRef = Database.database().reference().child("posts")
        postsRef.queryOrdered(byChild: "postType").queryEqual(toValue: "lost").observe(.value) { (snapshot) in
            
            var tempPost = [Posts]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    
                    let dict = childSnapshot.value as? [String: Any]
                   
                    //Author
                    let author = dict!["author"] as? [String: Any]
                    let uid = author!["userid"] as? String
                    let username = author!["username"] as? String
                    let userphotoUrl = author!["profilePhotoUrl"] as? String
                    let userurl = URL(string: userphotoUrl!)
                    let userProfile = UserProfile(uid: uid!, username: username!, photoUrl: userurl!)
                    
                    //Post Picture
                    let photoUrl = dict!["photoUrl"] as? String
                    let url = URL(string: photoUrl!)
                    
                    //Info Post
                    let city = dict!["city"] as? String
                    let municipality = dict!["municipality"] as? String
                    let name = dict!["name"] as? String
                    let breed = dict!["breed"] as? String
                    let phoneuser = dict!["phone"] as? String
                    let address = dict!["address"] as? String
                    let comments = dict!["comments"] as? String
                    let petType = dict!["petType"] as? String
                    let gender = dict!["gender"] as? String
                    let timestamp = dict!["timestamp"] as? Double
                    let date = Date(timeIntervalSince1970: timestamp!/1000)

                    let post = Posts(uid: childSnapshot.key, author: userProfile, name: name!, address: address!, breed: breed!, phone: phoneuser!, photoUrl: url!, city: city!, municipality: municipality!, petType: petType!, gender: gender!, timestamp: date, comments: comments!)
                    tempPost.insert(post, at: 0)
                }
                
                DispatchQueue.main.async {
                    self.posts = tempPost
                    self.lostCollectionView.reloadData()
                    self.refresherLost.endRefreshing()
                }
            }
        }
    }
    
    @objc func observePostsFound() {
        let postsRef = Database.database().reference().child("posts")
        postsRef.queryOrdered(byChild: "postType").queryEqual(toValue: "found").observe(.value) { (snapshot) in
            
            var tempPost = [PostsFound]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    
                    let dict = childSnapshot.value as? [String: Any]
                    
                    //Author
                    let author = dict!["author"] as? [String: Any]
                    let uid = author!["userid"] as? String
                    let username = author!["username"] as? String
                    let photoUrl = author!["profilePhotoUrl"] as? String
                    let userurl = URL(string: photoUrl!)
                    let userProfile = UserProfile(uid: uid!, username: username!, photoUrl: userurl!)
                    
                    //Post Picture
                    let photoUrlfound = dict!["photoUrl"] as? String
                    let url = URL(string: photoUrlfound!)
                    
                    //Info Post
                    let cityfound = dict!["city"] as? String
                    let municipalityfound = dict!["municipality"] as? String
                    let breedfound = dict!["breed"] as? String
                    let phoneuserfound = dict!["phone"] as? String
                    let addressfound = dict!["address"] as? String
                    let commentsfound = dict!["comments"] as? String
                    let petTypefound = dict!["petType"] as? String
                    let genderfound = dict!["gender"] as? String
                    let timestampfound = dict!["timestamp"] as? Double
                    let datefound = Date(timeIntervalSince1970: timestampfound!/1000)



                    let post = PostsFound(uid: childSnapshot.key, authorfound: userProfile, addressfound: addressfound!, breedfound: breedfound!, phonefound: phoneuserfound!, photoUrlfound: url!, cityfound: cityfound!, municipalityfound: municipalityfound!, petTypeFound: petTypefound!, genderfound: genderfound!, timestampfound: datefound, comments: commentsfound!)
                    
                    tempPost.insert(post, at: 0)
                }
                
                DispatchQueue.main.async {
                    self.postsfound = tempPost
                    self.foundCollectionView.reloadData()
                    self.refresherFound.endRefreshing()
                }
            }
        }
    }

    
    @objc func observePostsAdoption() {
        let postsRef = Database.database().reference().child("posts")
        postsRef.queryOrdered(byChild: "postType").queryEqual(toValue: "adopt").observe(.value) { (snapshot) in
            
            var tempPost = [PostsAdoption]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    
                    let dict = childSnapshot.value as? [String: Any]
                    
                    //Author
                    let author = dict!["author"] as? [String: Any]
                    let uid = author!["userid"] as? String
                    let username = author!["username"] as? String
                    let userphotoUrl = author!["profilePhotoUrl"] as? String
                    let userurl = URL(string: userphotoUrl!)
                    let userProfile = UserProfile(uid: uid!, username: username!, photoUrl: userurl!)
                    
                    //Post Picture
                    let photoUrl = dict!["photoUrl"] as? String
                    let url = URL(string: photoUrl!)
                    
                    //Info Post
                    let commentsadoption = dict!["comments"] as? String
                    let cityadoption = dict!["city"] as? String
                    let municipalityadoption = dict!["municipality"] as? String
                    let breedadoption = dict!["breed"] as? String
                    let phoneuseradoption = dict!["phone"] as? String
                     let petTypeadoption = dict!["petType"] as? String
                    let genderadoption = dict!["gender"] as? String
                    let timestampadoption = dict!["timestamp"] as? Double
                    let dateadoption = Date(timeIntervalSince1970: timestampadoption!/1000)
                    
                    
                    let post = PostsAdoption(uid: childSnapshot.key, authoradoption: userProfile, commentsadoption: commentsadoption!, breedadoption: breedadoption!, phoneadoption: phoneuseradoption!, photoUrladoption: url!, cityadoption: cityadoption!, municipalityadoption: municipalityadoption!, petTypeAdoption: petTypeadoption!, genderadoption: genderadoption!, timestampadoption: dateadoption)
                    
                    
                    tempPost.insert(post, at: 0)
                }
                
                DispatchQueue.main.async {
                    self.postsadoption = tempPost
                    self.adoptionCollectionView.reloadData()
                    self.refresherAdoption.endRefreshing()
                }
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
            
        if collectionView == self.foundCollectionView {
           
            return postsfound.count
            
        }
        
        if collectionView == self.adoptionCollectionView {
            
            return postsadoption.count
        }
        
        else {
            
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        
        case lostCollectionView:

            let lostcell: LostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Lostcell", for: indexPath) as! LostCollectionViewCell

            lostcell.set(post: posts[indexPath.row])

            //Make TextView Clickable
            lostcell.phoneLostTextView.isEditable = false;
            lostcell.phoneLostTextView.dataDetectorTypes = UIDataDetectorTypes.phoneNumber
            return lostcell


        case foundCollectionView:
            let foundcell: FoundCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Foundcell", for: indexPath) as! FoundCollectionViewCell

            foundcell.set(postfound: postsfound[indexPath.row])

            //Make TextView Clickable
            foundcell.phoneFoundTextView.isEditable = false;
            foundcell.phoneFoundTextView.dataDetectorTypes = UIDataDetectorTypes.phoneNumber
            return foundcell

        case adoptionCollectionView:
            let adoptioncell: AdoptionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Adopotioncell", for: indexPath) as! AdoptionCollectionViewCell

            adoptioncell.set(postadoption: postsadoption[indexPath.row])

            //Make TextView Clickable
            adoptioncell.phoneAdoptionTextView.isEditable = false;
            adoptioncell.phoneAdoptionTextView.dataDetectorTypes = UIDataDetectorTypes.phoneNumber
            return adoptioncell

        default:
            return UICollectionViewCell()
        }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        switch collectionView {
        
        case lostCollectionView:

            let vc = storyboard?.instantiateViewController(withIdentifier: "lostSelectedViewController") as? LostSelectedViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.posts = posts[indexPath.row]
            break
        
        case foundCollectionView:
           let vc = storyboard?.instantiateViewController(withIdentifier: "foundSelectedViewController") as? FoundSelectedViewController
           self.navigationController?.pushViewController(vc!, animated: true)
            vc?.postsfound = postsfound[indexPath.row]
            break

        case adoptionCollectionView:
            let vc = storyboard?.instantiateViewController(withIdentifier: "adoptionSelectedViewController") as? AdoptionSelectedViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.postsadoption = postsadoption[indexPath.row]
            break
        
        default:
            break
        }
    }
    

    
}

////SCROLL

extension  HomeViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    
}

