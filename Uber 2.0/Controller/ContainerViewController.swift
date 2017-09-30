//
//  ContainerViewController.swift
//  Uber 2.0
//
//  Created by Alex Wong on 9/30/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState{
    case Collapsed
    case LeftPanelExpanded
    
}

enum ShowWhichViewController{
    case HomeViewController
}

var showViewController: ShowWhichViewController = .HomeViewController

class ContainerViewController: UIViewController {

    var homeViewController: HomeViewController!
    var currentState: SlideOutState = .Collapsed {
        didSet{
            let shouldShowShadow = currentState != .Collapsed
            
            shouldShowShadowForCenterViewController(status: shouldShowShadow)
        }
    }
    var leftViewController: LeftSidePanelViewController!
    var centerController: UIViewController!
    
    var statusBarIsHidden = false
    let centerPanelExpandedOffset: CGFloat = 160
    
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showViewController)
    }
    
    func initCenter(screen: ShowWhichViewController){
        var presentingController: UIViewController
        showViewController = screen
        
        if homeViewController == nil{
            homeViewController = UIStoryboard.homeViewController()
            homeViewController.delegate = self
        }
        presentingController = homeViewController
        
        if let con = centerController{
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        centerController = presentingController
        
        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return UIStatusBarAnimation.slide
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return statusBarIsHidden
    }
}

extension ContainerViewController: CenterViewControllerDelegate{
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded{
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftViewController == nil {
            leftViewController = UIStoryboard.leftViewController()
            addChildSidePanelViewController(leftViewController!)
        }
    }
    
    func addChildSidePanelViewController(_ sidePanelViewController: LeftSidePanelViewController){
        view.insertSubview(sidePanelViewController.view, at: 0)
        addChildViewController(sidePanelViewController)
        sidePanelViewController.didMove(toParentViewController: self)
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand{
            statusBarIsHidden = !statusBarIsHidden
            animateStatusBar()
            setupWhiteCoverView()
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
            
            
        } else {
            statusBarIsHidden = !statusBarIsHidden
            animateStatusBar()
            hideWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: 0, completion: { (finished) in
                if finished == true{
                    self.currentState = .Collapsed
                    self.leftViewController = nil
                }
            })
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
        
    }
    
    func setupWhiteCoverView(){
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.2) {
            whiteCoverView.alpha = 0.75
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        
        self.centerController.view.addGestureRecognizer(tap)
    }
    
    func hideWhiteCoverView(){
        centerController.view.removeGestureRecognizer(tap)
        for subview in self.centerController.view.subviews{
            if subview.tag == 25{
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }, completion: { (finished) in
                    subview.removeFromSuperview()
                })
            }
        }
    }
    
    // show shadow
    
    func shouldShowShadowForCenterViewController(status: Bool){
        if status == true{
            centerController.view.layer.shadowOpacity = 0.6
        } else {
            centerController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func animateStatusBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
}

// use private so that only ContainerVC has access to this extension
// create to use main.storyboard
private extension UIStoryboard{
    
    class func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
        
    }
    
    class func leftViewController() -> LeftSidePanelViewController?{
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSidePanelViewController") as? LeftSidePanelViewController
    }
    
    class func homeViewController() -> HomeViewController{
        return (mainStoryboard().instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)!
    }
    
}
