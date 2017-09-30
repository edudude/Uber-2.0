//
//  CircleView.swift
//  
//
//  Created by Alex Wong on 9/30/17.
//

import UIKit

class CircleView: UIView {

    // Inspectable is just like a variable that allows you to set and manipulate colors and borders independently
    @IBInspectable var borderColor: UIColor?{
        didSet{
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
    }

}
