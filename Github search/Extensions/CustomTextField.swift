//
//  CustomTextField.swift
//  Github search
//
//  Created by Niec, Mateusz on 16/09/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 5,
        bottom: 10,
        right: 5
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
}
