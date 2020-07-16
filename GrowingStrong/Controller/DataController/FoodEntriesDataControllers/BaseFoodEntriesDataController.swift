//
//  BaseFoodEntriesDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-16.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol BaseFoodEntriesDataControllerDelegate: class {
    func rowSelected(at row: Int)
}

class BaseFoodEntriesDataController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var cellIdentifier: String!
    var foodEntryViewModels: [FoodEntryViewModel]!
    weak var baseFoodEntriesDataControllerDelegate: BaseFoodEntriesDataControllerDelegate?
    
    init(cellIdentifier: String, foodEntryViewModels: [FoodEntryViewModel]) {
        self.cellIdentifier = cellIdentifier
        self.foodEntryViewModels = foodEntryViewModels
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodEntryViewModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        baseFoodEntriesDataControllerDelegate?.rowSelected(at: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodCell
        let foodEntryViewModel = foodEntryViewModels[indexPath.item]
        cell.nameLabel.text = foodEntryViewModel.food.foodName
        cell.caloriesLabel.text = foodEntryViewModel.totalCaloriesText
        cell.quantityLabel.text = foodEntryViewModel.totalQuantityText
        return cell
    }
    
    func updateFoodEntryViewModels(_ foodEntryViewModels: [FoodEntryViewModel]) {
        self.foodEntryViewModels = foodEntryViewModels
    }
}
