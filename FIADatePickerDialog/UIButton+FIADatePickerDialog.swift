//
//  UIButton+FIAButton.swift
//  FIADatePickerDialog
//
//  Created by Айрат Галиуллин on 14.12.16.
//  Copyright © 2016 Fucher in Apps OOO. All rights reserved.
//

import UIKit

fileprivate var rawPointer: UInt8 = 0
fileprivate var rawPointer_Bool: UInt8 = 1

protocol FIADatePickerDialogActionDelegate {
    func submit()
    func cancel()
}

extension UIButton {
    var delegate:FIADatePickerDialogActionDelegate?{
        set{
            objc_setAssociatedObject(self, &rawPointer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return objc_getAssociatedObject(self, &rawPointer) as? FIADatePickerDialogActionDelegate
        }
    }
    
    var isDatePickerAction:Bool?{
        set{
            objc_setAssociatedObject(self, &rawPointer_Bool, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return objc_getAssociatedObject(self, &rawPointer_Bool) as? Bool
        }
    }
    
    private var defaultBGRColor:UIColor?{
        set{
            objc_setAssociatedObject(self, &rawPointer_Bool, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return objc_getAssociatedObject(self, &rawPointer_Bool) as? UIColor
        }
    }
    
    func submit(_ sender:UIButton!){
        guard delegate != nil else {
            fatalError("DatePickerDialogActions delegate should not be nil")
        }
        delegate?.submit()
    }
    
    func cancel(_ sender:UIButton!){
        guard delegate != nil else {
            fatalError("DatePickerDialogActions delegate should not be nil")
        }
        delegate?.cancel()
    }
    
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if isDatePickerAction != nil && isDatePickerAction! {
            backgroundColor = UIColor.hexStringToUIColor(hex: "222222",alpha:0.3)
        }
        return true
    }
    
    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if isDatePickerAction != nil && isDatePickerAction! {
            backgroundColor = UIColor.clear
        }
    }
}
