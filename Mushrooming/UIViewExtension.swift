//
//  UIViewExtension.swift
//  Mushrooming
//
//  Created by Łukasz Sokołowski on 21/09/2017.
//  Copyright © 2017 Łukasz Sokołowski. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
}
