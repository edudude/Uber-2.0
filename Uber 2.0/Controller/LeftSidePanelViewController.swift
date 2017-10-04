//
//  LeftSidePanelViewController.swift
//  Uber 2.0
//
//  Created by Alex Wong on 9/30/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

class LeftSidePanelViewController: UIViewController {
    
    @IBOutlet weak var pickUpModeLabel: UILabel!
    @IBOutlet weak var pickUpModeSwitch: UISwitch!
    @IBOutlet weak var authenticateButton: UIButton!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var userAccountTypeLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    @IBAction func signUpLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(loginViewController, animated: true, completion: nil)
    }
}
