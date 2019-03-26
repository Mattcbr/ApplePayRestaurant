//
//  FoodTableViewCell.swift
//  iEats
//
//  Created by Matheus Queiroz on 26/03/19.
//  Copyright © 2019 Matheus Queiroz. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupForFood(foodToSetup: FoodModel){
        foodNameLabel.text = foodToSetup.name
        foodDescriptionLabel.text = foodToSetup.detailedDescription
        foodPriceLabel.text = String(format: "R$ %.2f", foodToSetup.price )
        
        var imageToSetup = UIImage(named: "logo")
        switch foodToSetup.imageID {
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
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
