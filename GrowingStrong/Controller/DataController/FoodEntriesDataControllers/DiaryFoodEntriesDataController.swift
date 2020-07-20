//
//  DiaryFoodEntriesDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol DiaryFoodEntriesDataControllerDelegate: class {
    func rowDeleted(at row: Int)
}

class DiaryFoodEntriesDataController: BaseFoodEntriesDataController {
    weak var diaryFoodEntriesDataControllerDelegate: DiaryFoodEntriesDataControllerDelegate?
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            diaryFoodEntriesDataControllerDelegate?.rowDeleted(at: indexPath.item)
        }
    }
}
