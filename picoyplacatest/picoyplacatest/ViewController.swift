//
//  ViewController.swift
//  picoyplacatest
//
//  Created by Diego Cando on 17/12/19.
//  Copyright © 2019 Diego Cando. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var dateTime: UITextField!
    @IBOutlet weak var plate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let calendar = Calendar.current
        //When loading set the current date time as an example
        dateTime.text = "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date)) \(zeroFill(data: calendar.component(.hour, from: date),length: 2)):\(zeroFill(data: calendar.component(.minute, from: date),length: 2)):\(zeroFill(data: calendar.component(.second, from: date),length: 2))"
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func checkData(_ sender: Any) {
        let inputPlate: String = plate.text ?? ""
        let inputTime: String = dateTime.text ?? ""
        result.text = safe(plate: inputPlate, datetime: inputTime)
    }
    
}

