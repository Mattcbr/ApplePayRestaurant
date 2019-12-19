//
//  PurchaseDetailsViewController.swift
//  iEats
//
//  Created by Matheus Queiroz on 05/04/19.
//  Copyright © 2019 Matheus Queiroz. All rights reserved.
//

import UIKit

class PurchaseDetailsViewController: UIViewController {

    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    
    var shippingId: String?
    var foodName: String?
    var costumerName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(shippingId == "deliveryShipping"){
            setupForDelivery()
        } else if (shippingId == "inStoreShipping"){
            setupForInStore()
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressOkButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupForDelivery(){
        mainTextLabel.text = "The \(foodName!) is on it's way to \(costumerName!)"
        detailTextLabel.text = "It will take about 30-45 mins to get there. Keep looking at our app for more information 😀"
    }

    func setupForInStore(){
        mainTextLabel.text = "Hooray! You're paying us a visit!"
        detailTextLabel.text = "We're so excited that you're coming.\n When you arrive, please ask for \(costumerName!)'s \(foodName!) at our front desk.\n Don't forget we are located at 1117 California Ave, Palo Alto, CA.\n Don't keep us waiting 😉"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
