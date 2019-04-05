//
//  FoodDetailsViewController.swift
//  iEats
//
//  Created by Matheus Queiroz on 21/03/19.
//  Copyright © 2019 Matheus Queiroz. All rights reserved.
//

import UIKit
import PassKit

class FoodDetailsViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    
    var selectedFood: FoodModel?
    let request = PKPaymentRequest()
    var summaryItens = [PKPaymentSummaryItem]()
    var shippingMethodss = [PKShippingMethod]()
    var shippingPrice: NSDecimalNumber?{
        didSet{
            updateSummary()
        }
    }
    
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
        applePayButton.addTarget(self, action: #selector(applePayButtonTapped(sender:)), for: .touchUpInside)
        view.addSubview(applePayButton)
        
        view.addConstraint(NSLayoutConstraint(item: applePayButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: applePayButton, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: applePayButton, attribute: .width, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .width, multiplier: 0.8, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: applePayButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
    }
    
    @objc private func applePayButtonTapped(sender: UIButton){
        let SupportedPaymentNetworks = [PKPaymentNetwork.masterCard, PKPaymentNetwork.visa, PKPaymentNetwork.amex]
        request.merchantIdentifier = "merchant.com.shiningdevelopers"
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.countryCode = "BR"
        request.currencyCode = "BRL"
        request.requiredShippingContactFields = [.name, .postalAddress]
        
        let delivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(integerLiteral: 5), type: .final)
        delivery.identifier = "deliveryShipping"
        delivery.detail = "We'll deliver it right at your door"
        
        let inStore = PKShippingMethod(label: "In Store", amount: NSDecimalNumber(integerLiteral: 0), type: .final)
        inStore.identifier = "inStoreShipping"
        inStore.detail = "You'll come visit us!"
        
        shippingMethodss = [delivery, inStore]
        request.shippingMethods = shippingMethodss
        shippingPrice = request.shippingMethods?.first?.amount
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        if let viewController = applePayController {
            viewController.delegate = self
            present(viewController, animated: true, completion: nil)
        }
    }
    
    func updateSummary() {
        request.paymentSummaryItems = [PKPaymentSummaryItem]()
        
        let foodItem = PKPaymentSummaryItem(label: selectedFood!.name, amount: NSDecimalNumber(floatLiteral: Double(selectedFood!.price)))
        let shippingItem = PKPaymentSummaryItem(label: "shipping", amount: shippingPrice ?? 0)
        let total = PKPaymentSummaryItem(label: "iEats", amount: foodItem.amount.adding(shippingItem.amount))
        
        request.paymentSummaryItems = [foodItem, shippingItem, total]
        summaryItens = [foodItem, shippingItem, total]
    }
    
    // MARK - PKPaymentAuthorizationViewControllerDelegate
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        //Perform Segue
        controller.dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect shippingMethod: PKShippingMethod, handler completion: @escaping (PKPaymentRequestShippingMethodUpdate) -> Void) {
        //The shipping method was changed, handle it here
        shippingPrice = shippingMethod.amount
        let update = PKPaymentRequestShippingMethodUpdate(paymentSummaryItems: summaryItens)
        completion(update)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelectShippingContact contact: PKContact, handler completion: @escaping (PKPaymentRequestShippingContactUpdate) -> Void) {
        let zip = contact.postalAddress?.postalCode
        let zipError = PKPaymentRequestShippingContactUpdate.init()
        if(zip?.first != "9"){
            print("Error")
            zipError.status = .failure
            zipError.errors.append(PKPaymentRequest.paymentShippingAddressInvalidError(withKey: "donotdeliver", localizedDescription: "Sorry, we do not deliver that far :("))
        }
        completion(zipError)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        completion(PKPaymentAuthorizationResult.init(status: .success, errors: nil))
    }
}
