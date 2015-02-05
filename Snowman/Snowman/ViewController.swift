//
//  ViewController.swift
//  Snowman
//
//  Created by challenge on 2/5/15.
//  Copyright (c) 2015 com.thesyedahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, FBLoginViewDelegate { //adding FBLoginViewDelegate
    
    @IBOutlet var fbLoginView : FBLoginView! //creating the outlet

    @IBOutlet weak var btnStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnStart.hidden = true
        //initiating LoginView
        self.fbLoginView.delegate = self
        //initiating permission levels (could be modified for photo permissions etc.)
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    @IBAction func btnStartTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else{
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    //Facebook Delegate Methods
    
    
    //when user has already logged in
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        println("This is where you perform a segue.") //using this segue, can go to home app.
        self.btnStart.hidden = false
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        println("User Name: \(user.name)") //getting user information
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out") //when user logs out
        self.btnStart.hidden = true
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)") //when we get an error
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

