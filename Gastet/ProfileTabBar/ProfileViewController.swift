//
//  ProfileViewController.swift
//  Gastet
//
//  Created by Ximena Flores de la Tijera on 5/30/18.
//  Copyright © 2018 ximeft29. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    //variables firebase
    var currentUser = Auth.auth().currentUser
    let databaseRef = Database.database().reference()
    let storage = Storage.storage().reference()
    
    //VARS
    var postsuser = [ProfileUserPosts]()
    
    //Refresher
    var refresher: UIRefreshControl = UIRefreshControl()

    //@IBOUTLETS
    
        //labels & buttons
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
        //collection view related
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var postsView: UIView!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    //@IBACTIONS
    
        //segue to edit user info
    @IBAction func editUserInformationButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "editUserInformation", sender: self)
        
    }

        //logout @ibaction
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        
        print(Auth.auth().currentUser!)
        logout()

    }

    //VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid == nil {
            logout()
        }

        //COLLECTIONVIEW
        scrollView.delegate = self
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        
        //functions
        displayUserInformation()

        setupNavigationBarItems()

//        observeUserPosts()
        observeUserPosts()
        
        //Refresher
        refresher.addTarget(self, action: #selector(postsCollectionView.reloadData), for: UIControlEvents.valueChanged)
        postsCollectionView.addSubview(refresher)
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //funcs
    
    
    func logout() {
        
        do {
            
            try Auth.auth().signOut()
            
        } catch let logoutError {
            print(logoutError)
        }
        
        print(Auth.auth().currentUser)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
        self.present(signUpVC , animated: true, completion: nil)
        
    }
    
    private func setupNavigationBarItems() {
        
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "gastet_eye_logo"))
        
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
        
    }
    
    
    
    //func - display profile info (username - profile pic)
    
    func displayUserInformation() {
   
            let uid = Auth.auth().currentUser?.uid
            databaseRef.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
                if let dict = snapshot.value as? [String: AnyObject] {
                
                    self.username.text = dict["username"] as? String
                    self.email.text = dict["email"] as? String
                    
                    if let profileImageUrl = dict["photoUrl"] as? String {
                        
                        let url = URL(string: profileImageUrl)
                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                            if error != nil {
                                print(error)
                                return
                            }
                            
                            DispatchQueue.main.async {
                                self.profilePicture?.image = UIImage(data: data!)
                            }
                            
                        }).resume()
                        
                    }
            
                }}, withCancel: nil)
        
    }

    @objc func observeUserPosts() {
        let uid = Auth.auth().currentUser?.uid
        let postsRef = Database.database().reference().child("posts").queryOrdered(byChild: "author/userid")
        postsRef.queryEqual(toValue: uid!).observe(.value) { (snapshot) in

            print("Hola")
            print(snapshot)
            var tempPost = [ProfileUserPosts]()

            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {

                    let dict = childSnapshot.value as? [String: Any]

                    //Post Picture
                    let photoUrl = dict!["photoUrl"] as? String
                    let url = URL(string: photoUrl!)

                    //Info Post
                    let comments = dict!["comments"] as? String
                    let name = dict!["name"] as? String
                    let address = dict!["address"] as? String
                    let city = dict!["city"] as? String
                    let municipality = dict!["municipality"] as? String
                    let breed = dict!["breed"] as? String
                    let phoneuser = dict!["phone"] as? String
                    let postType = dict!["postType"] as? String
                    let petType = dict!["petType"] as? String
                    let gender = dict!["gender"] as? String
                    let timestampadoption = dict!["timestamp"] as? Double
                    let date = Date(timeIntervalSince1970: timestampadoption!/1000)

                    let post = ProfileUserPosts(name: name ?? "", address: address ?? "", breed: breed!, phone: phoneuser!, photoUrl: url!, city: city!, municipality: municipality!, petType: petType!, gender: gender!, timestamp: date, postType: postType!, comments: comments!, timestampDouble: timestampadoption!)

                    tempPost.insert(post, at: 0)
                }

                DispatchQueue.main.async {
                    self.postsuser = tempPost
                    self.postsCollectionView.reloadData()
                    self.refresher.endRefreshing()
                }
            }
        }
    }

    
    
    //ALERTS
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 

}

//extension - UICollectionView for user's posts

extension ProfileViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return postsuser.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PostsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "postsCell", for: indexPath) as! PostsCollectionViewCell

        cell.set(post: postsuser[indexPath.row])
        cell.deletePostButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        cell.deletePostButton.tag = indexPath.row
        return cell
    }
    
    @objc func buttonAction(sender: UIButton) {
    
       ProgressHUD.show("Un momento", interaction: true)
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("posts").queryOrdered(byChild: "author/userid").queryEqual(toValue: uid!).observe(.value) { (snapshot) in
            if let posts = snapshot.value as? [String: AnyObject] {
                if let posts = snapshot.value as? [String: AnyObject] {
                    for (key, postReference) in posts {
                        if let post = postReference as? [String: Any], let timestamp = post["timestamp"] as? TimeInterval, timestamp == self.postsuser[sender.tag].timestampDouble {
                            
                            Database.database().reference().child("posts").child(key).removeValue(completionBlock: { (error, _) in
                                DispatchQueue.main.async {
                                    ProgressHUD.showSuccess("Tu imagen ha sido borrada...")
                                    self.postsuser.remove(at: sender.tag)
                                    self.postsCollectionView.reloadData()
                                    self.refresher.endRefreshing()
                                }
                            })
                        }
                    }
            }
        }
    }
}
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "profileUsersSelectedPostViewController") as? ProfileUsersSelectedPostViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.selectedpostsuser = postsuser[indexPath.row]
    }
}

//extension - scroll view


extension  ProfileViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
}

