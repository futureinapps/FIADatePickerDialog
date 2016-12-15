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
        configureFIADatePickerDialog()
    }
    
    func configureFIADatePickerDialog(){
        fiaDPD = FIADatePickerDialog(with:view)
        fiaDPD.delegate = self
        fiaDPD.cancelActionTitle = "CLOSE"
        fiaDPD.submitActionTitle = "CHOOSE"
    }
    
    func submit(with date: Date!) {
        let dFormatter = DateFormatter()
        dFormatter.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dFormatter.string(from: date)
    }
    
    func cancel() {
        print("canceled")
    }
    
    @IBAction func showDatePickerDialog(_ sender: Any) {
        fiaDPD.show(mode: .date,with:true)
    }
    
    @IBAction func clearDate(_ sender: Any) {
        dateLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

