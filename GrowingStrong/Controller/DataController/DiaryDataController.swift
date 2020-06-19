//
//  FoodEntriesDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol DiaryDataControllerDelegate: class {
    func rowSelected(at row: Int)
}

class FoodEntriesDataController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var cellIdentifier: String!
    var foodEntryViewModels: [FoodEntryViewModel]!
    weak var delegate: DiaryDataControllerDelegate?
    
    init(cellIdentifier: String, foodEntryViewModels: [FoodEntryViewModel]) {
        self.cellIdentifier = cellIdentifier
        self.foodEntryViewModels = foodEntryViewModels
    }
    
    func updateFoodEntryViewModels(_ foodEntryViewModels: [FoodEntryViewModel]) {
        self.foodEntryViewModels = foodEntryViewModels
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodEntryViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodCell
        let foodEntryViewModel = foodEntryViewModels[indexPath.item]
        cell.nameLabel.text = foodEntryViewModel.food.name
        cell.caloriesLabel.text = foodEntryViewModel.totalCaloriesText
        cell.quantityLabel.text = foodEntryViewModel.totalQuantityText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.rowSelected(at: indexPath.item)
    }
}
