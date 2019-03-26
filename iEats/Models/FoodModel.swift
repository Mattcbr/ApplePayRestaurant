//
//  FoodModel.swift
//  iEats
//
//  Created by Matheus Queiroz on 26/03/19.
//  Copyright © 2019 Matheus Queiroz. All rights reserved.
//

import Foundation

class FoodModel {
    var name: String
    var detailedDescription: String
    var price: Float
    var imageID: Int
    
    init(withName: String, foodDescription: String, fullPrice: Float, image: Int) {
        self.name = withName
        self.detailedDescription = foodDescription
        self.price = fullPrice
        self.imageID = image
    }
    
}
