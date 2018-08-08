//
//  ViewController.swift
//  FlatPaymentMethod
//
//  Created by christianampe on 08/06/2018.
//  Copyright (c) 2018 christianampe. All rights reserved.
//

import UIKit
import FlatPaymentMethod

class ViewController: UIViewController {
    @IBOutlet weak var creditCard: CreditCardView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func textFieldEdited(_ sender: Any) {
        guard let text = textField.text else {
            return
        }
        
        creditCard.validateNumber(text)
    }
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

