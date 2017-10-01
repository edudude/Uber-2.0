//
//  HomeViewController.swift
//  Uber 2.0
//
//  Created by Alex Wong on 9/29/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, MKMapViewDelegate {

    // MARK: - Properties
    var delegate: CenterViewControllerDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var actionButton: RoundedShadowButtonView!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func actionButtonPressed(_ sender: Any) {
        actionButton.animateButton(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }
}

