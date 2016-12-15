//
//  UIColor+FIADatePickerDialog.swift
//  FIADatePickerDialog
//
//  Created by Айрат Галиуллин on 15.12.16.
//  Copyright © 2016 Fucher in Apps OOO. All rights reserved.
//


import UIKit

extension UIColor {
    
    class func fia_yellow(_ alpha:CGFloat = 1.0)->UIColor{
        return UIColor(colorLiteralRed: 255/255, green: 204/255, blue: 51/255, alpha: Float(alpha))
    }
    
    class func hexStringToUIColor (hex:String,alpha:CGFloat = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

