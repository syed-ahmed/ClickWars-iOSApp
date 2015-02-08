//
//  loginViewController.swift
//  Snowman
//
//  Created by challenge on 2/7/15.
//  Copyright (c) 2015 com.thesyedahmed. All rights reserved.
//

import Foundation

class logInViewController : UIViewController {
    
    @IBOutlet var loginInitialLabel: UILabel!
    
    @IBOutlet var logInSavePassLabel: UILabel!
    
    @IBOutlet var loginInUserTextField: UITextField!
    
    @IBOutlet var logInPassTextField: UITextField!
    
    @IBOutlet var logInSavePassSwitch: UISwitch!
    
    @IBAction func logInActionButton(sender: AnyObject) {
        if loginInUserTextField.text != "" && logInPassTextField.text != "" {
            
        } else {
            
            self.loginInitialLabel.text = "All Fields Required"
        }
        
        if logInSavePassSwitch.on {
        } else {
        }
        PFUser.logInWithUsernameInBackground(loginInUserTextField.text, password:logInPassTextField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                
                self.loginInitialLabel.text = "User Exists"
            } else {
                
            }
        }
    }

    
}