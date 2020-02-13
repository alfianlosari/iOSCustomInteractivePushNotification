//
//  ViewController.swift
//  apnspushsimulate
//
//  Created by Alfian Losari on 10/02/20.
//  Copyright © 2020 alfianlosari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = "Drag & Drop valid APNS file to the target simulator to begin (2 of sample APNS file is in the project directory). Make sure to accept the push notification permission and put the app in background before"
    }
}


