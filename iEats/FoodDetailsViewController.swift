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
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    
    var selectedFood: FoodModel?
    
    override func viewDidLoad() {
        setupForFood()
        addApplePayButton()
        
        self.navigationItem.title = selectedFood?.name
    }
    
    func setupForFood(){
        
        foodNameLabel.text = selectedFood?.name
        foodPriceLabel.text = String(format: "R$ %.2f", selectedFood?.price ?? 10000.00)
        foodDescriptionLabel.text = selectedFood?.detailedDescription
        
        var imageToSetup = UIImage(named: "logo")
        switch selectedFood?.imageID {
        case 1:
            imageToSetup = UIImage(named: "burger")
        case 2:
            imageToSetup = UIImage(named: "fries")
        case 3:
            imageToSetup = UIImage(named: "pizza")
        case 4:
            imageToSetup = UIImage(named: "pasta")
        case 5:
            imageToSetup = UIImage(named: "cake")
        default:
            print("Image Not Really Handled")
        }
        foodImageView.image = imageToSetup
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
