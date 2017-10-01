//
//  RoundedCornerTextField.swift
//  Uber 2.0
//
//  Created by Alex Wong on 9/30/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

class RoundedCornerTextField: UITextField {

    var textRectOffSet: CGFloat = 20
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.height/2
    }
    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(x: 0 + textRectOffSet, y: 0 + (textRectOffSet/2), width: self.frame.width - textRectOffSet, height: self.frame.height + textRectOffSet)
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(x: 0 + textRectOffSet, y: 0 + (textRectOffSet/2), width: self.frame.width - textRectOffSet, height: self.frame.height + textRectOffSet)
//    }
    
}
