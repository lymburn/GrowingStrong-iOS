//
//  SearchFoodEntriesDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-16.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class SearchFoodEntriesDataController: BaseFoodEntriesDataController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodCell
        let foodEntryViewModel = foodEntryViewModels[indexPath.item]
        cell.nameLabel.text = foodEntryViewModel.food.foodName
        cell.caloriesLabel.text = foodEntryViewModel.shortTotalCaloriesText
        cell.quantityLabel.text = foodEntryViewModel.totalQuantityText
        return cell
    }
}
