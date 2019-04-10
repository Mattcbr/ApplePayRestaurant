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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressOkButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
        self.dismiss(animated: true, completion: nil)
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
