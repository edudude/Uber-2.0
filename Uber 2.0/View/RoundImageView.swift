//
//  RoundImageView.swift
//  Uber 2.0
//
//  Created by Alex Wong on 9/30/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        setupCircleView()
    }
    
    func setupCircleView(){
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true // cookie cut image to fit in the circle
    }

}
