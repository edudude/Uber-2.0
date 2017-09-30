//
//  RoundedShadowView.swift
//  Uber 2.0
//
//  Created by Alex Wong on 9/30/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        setupShadowView()
    }
    
    func setupShadowView(){
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.3 //30%
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0 //how far shadow extends
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    

}
