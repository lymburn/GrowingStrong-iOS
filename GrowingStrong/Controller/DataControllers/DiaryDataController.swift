//
//  DiaryDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol DiaryDataControllerDelegate: class {
    func rowSelected(at row: Int)
}

class DiaryDataController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var cellIdentifier: String!
    var foodViewModels: [FoodViewModel]!
    weak var delegate: DiaryDataControllerDelegate?
    
    init(cellIdentifier: String, foodViewModels: [FoodViewModel]) {
        self.cellIdentifier = cellIdentifier
        self.foodViewModels = foodViewModels
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodCell
        let foodViewModel = foodViewModels[indexPath.item]
        cell.nameLabel.text = foodViewModel.name
        cell.caloriesLabel.text = foodViewModel.totalCaloriesText
        cell.quantityLabel.text = foodViewModel.totalQuantityText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.rowSelected(at: indexPath.item)
    }
}
