//
//  ViewController.swift
//  FIADatePickerDialogExample
//
//  Created by Айрат Галиуллин on 14.12.16.
//  Copyright © 2016 Fucher in Apps OOO. All rights reserved.
//

import UIKit
import FIADatePickerDialog

class ViewController: UIViewController,FIADatePickerDialogDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    var fiaDPD:FIADatePickerDialog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePickerDialog()
    }
    
    func configureDatePickerDialog(){
        fiaDPD = FIADatePickerDialog(with: view)
        fiaDPD.delegate = self
        fiaDPD.cancelActionTitle = "CLOSE"
        fiaDPD.submitActionTitle = "CHOOSE"
    }
    
    @IBAction func chooseDate(_ sender: Any) {
        fiaDPD.show(mode: .date,withSender:sender)
    }

    @IBAction func clearDate(_ sender: Any) {
        dateLabel.text = ""
    }

    func submit(with date: Date!,and sender:Any) {
        print(sender)
        let dF = DateFormatter()
        dF.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dF.string(from: date)
    }
    
    func cancel(with sender:Any) {
        print(sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

