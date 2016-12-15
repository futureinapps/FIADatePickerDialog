//
//  FIADatePickerDialogLabel.swift
//  FIADatePickerDialog
//
//  Created by Айрат Галиуллин on 15.12.16.
//  Copyright © 2016 Fucher in Apps OOO. All rights reserved.
//

import UIKit

class FIADatePickerDialogLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
