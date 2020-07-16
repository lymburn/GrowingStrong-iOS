//
//  FoodEntriesDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol FoodEntriesDataControllerDelegate: class {
    func rowSelected(at row: Int)
    func rowDeleted(at row: Int)
}

class FoodEntriesDataController: BaseFoodEntriesDataController {
    weak var delegate: FoodEntriesDataControllerDelegate?
    
    func updateFoodEntryViewModels(_ foodEntryViewModels: [FoodEntryViewModel]) {
        self.foodEntryViewModels = foodEntryViewModels
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.rowSelected(at: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            delegate?.rowDeleted(at: indexPath.item)
        }
    }
}
