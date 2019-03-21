//
//  FoodDetailsViewController.swift
//  iEats
//
//  Created by Matheus Queiroz on 21/03/19.
//  Copyright © 2019 Matheus Queiroz. All rights reserved.
//

import UIKit
import PassKit

class FoodDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        addApplePayButton()
    }
    
    func addApplePayButton(){
        let applePayButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        applePayButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(applePayButton)
        
        view.addConstraint(NSLayoutConstraint(item: applePayButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: applePayButton, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: applePayButton, attribute: .width, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .width, multiplier: 0.8, constant: 0))
    }
}
