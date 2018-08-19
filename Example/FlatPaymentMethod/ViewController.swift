//
//  ViewController.swift
//  FlatPaymentMethod
//
//  Created by christianampe on 08/06/2018.
//  Copyright (c) 2018 christianampe. All rights reserved.
//

import UIKit
import FlatCreditCard
import FlatPaymentMethod

class ViewController: UIViewController {
    @IBOutlet weak var creditCard: CreditCardView!
    @IBOutlet weak var textField: UITextField!
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = PaymentViewModel(delegate: creditCard)
        creditCard.setViewModel(viewModel)
    }
}

extension ViewController {
    @IBAction func valueChanged(_ sender: Any) {
        creditCard.number = textField.text ?? ""
    }
}
