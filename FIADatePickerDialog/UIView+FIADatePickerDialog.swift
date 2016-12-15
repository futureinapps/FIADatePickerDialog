//
//  UIView+FIAView.swift
//  FIADatePickerDialog
//
//  Created by Айрат Галиуллин on 14.12.16.
//  Copyright © 2016 Fucher in Apps OOO. All rights reserved.
//

import UIKit

enum BorderSide {
    case Top
    case Bottom
    case Left
    case Right
}

extension UIView {
    func addSideBorder(on side:BorderSide, with color:UIColor, and width:CGFloat=1.0){
        let border = CALayer()
        border.borderColor = color.cgColor
        var x:CGFloat = 0
        var y:CGFloat = 0
        var w:CGFloat = frame.size.width
        var h:CGFloat = frame.size.height
        switch side {
        case .Top:
            h = width
            break
        case .Bottom:
            y = frame.size.height - width
            h = width
            break
        case .Left:
            w = width
            break
        case .Right:
            x = frame.size.width - width
            w = width
            break
        }
        border.frame = CGRect(x: x, y: y, width: w, height: h)
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
    func round(for corner:UIRectCorner,with radius:CGFloat){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width:radius,height:radius))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
}
