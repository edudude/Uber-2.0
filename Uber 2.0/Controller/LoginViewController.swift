//
//  LoginViewController.swift
//  Uber 2.0
//
//  Created by Alex Wong on 9/30/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: RoundedCornerTextField!
    @IBOutlet weak var passwordTextField: RoundedCornerTextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var authButton: RoundedShadowButtonView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.bindToKeyboard()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func cancelSignUpLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func authUser(_ sender: Any) {
        if emailTextField.text != nil && passwordTextField.text != nil{
            authButton.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            
            if let email = emailTextField.text, let password = passwordTextField.text{
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        if let user = user {
                            // if passenger bar is selected
                            if self.segmentedControl.selectedSegmentIndex == 0{
                                let userData = ["provider" : user.providerID] as [String:Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = ["provider" : user.providerID, "userIsDriver" : true, "isPickupModeEnabled" : false, "driverIsOnTrip" : false] as [String:Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                            }
                            
                    
                        }
                        print("Email user authenticated successfully with firebase")
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        if let errorCode = AuthErrorCode(rawValue: error!._code){
                            switch errorCode{
                            case .wrongPassword:
                                print("Wrong password.")
                            default:
                                print("An unexpected error occurred. Please try again.")
                            }
                        }
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil{
                                if let errorCode = AuthErrorCode(rawValue: error!._code){
                                    switch errorCode{
                                    case .emailAlreadyInUse:
                                        print("Email already in use.")
                                    case .invalidEmail:
                                        print("Invalid email, try again")
                                    default:
                                        print("An unexpected error occurred. Please try again.")
                                    }
                                    if errorCode == AuthErrorCode.invalidEmail{
                                        print("Invalid email, please try again.")
                                    }
                                }
                            } else {
                                if let user = user {
                                    if self.segmentedControl.selectedSegmentIndex == 0 {
                                        let userData = ["provider" : user.providerID] as [String:Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                                    } else {
                                        let userData = ["provider" : user.providerID, "userIsDriver" : true, "isPickupModeEnabled" : false, "driverIsOnTrip" : false] as [String:Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                                    }
                                }
                                print("Successfully created a new user with firebase")
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        }
    }
}
