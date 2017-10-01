//
//  LeftSidePanelViewController.swift
//  Uber 2.0
//
//  Created by Alex Wong on 9/30/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

class LeftSidePanelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(loginViewController, animated: true, completion: nil)
    }
}
