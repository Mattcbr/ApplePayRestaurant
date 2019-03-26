//
//  MenuViewController.swift
//  iEats
//
//  Created by Matheus Queiroz on 26/03/19.
//  Copyright © 2019 Matheus Queiroz. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    var foodArray = [FoodModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createFakeFood()
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Populate Food Array
    func createFakeFood(){
        let burger = FoodModel(withName: "Cheese Bacon",
                               foodDescription: "The popular bacon-filled delight",
                               fullPrice: 12.5,
                               image: 1)
        let fries = FoodModel(withName: "Wrinkled Fries",
                              foodDescription: "The well-known fries, with our awesome seasoning and cheddar dips",
                              fullPrice: 8.0,
                              image: 2)
        let pizza = FoodModel(withName: "Pepperoni Pizza",
                              foodDescription: "The best pizza in town",
                              fullPrice: 16.8,
                              image: 3)
        let pasta = FoodModel(withName: "Penne Alfredo",
                              foodDescription: "A taste of Italy",
                              fullPrice: 15.25,
                              image: 4)
        let cake = FoodModel(withName: "Lava Cake",
                             foodDescription: "The best way to finish a meal, sweet and full of chocolate",
                             fullPrice: 5.5,
                             image: 5)
        
        foodArray.append(contentsOf: [burger,fries,pizza,pasta,cake])
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? FoodTableViewCell else {
            fatalError("Not a food cell")
        }
        
        let foodToSetup = foodArray[indexPath.row]
        cell.setupForFood(foodToSetup: foodToSetup)

        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedCell = sender as! FoodTableViewCell
        let selectedCellIndexPath = self.tableView.indexPath(for: selectedCell)
        let selectedFood = foodArray[selectedCellIndexPath!.row]
        
        let destinationViewController = segue.destination as! FoodDetailsViewController
        destinationViewController.selectedFood = selectedFood
    }
    
}
