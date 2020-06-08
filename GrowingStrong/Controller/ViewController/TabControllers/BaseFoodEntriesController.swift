//
//  BaseFoodEntriesController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-26.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class BaseFoodEntriesListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFoodEntryViewModels(testFoodEntries.map({return FoodEntryViewModel.init(foodEntry: $0)}))
        foodEntriesTableView.register(FoodCell.self, forCellReuseIdentifier: foodEntryCellId)
        
        setupViews()
    }
    
    var foodEntryViewModels: [FoodEntryViewModel]!
    let foodEntryCellId = "foodEntryCellId"
    
    lazy var foodEntriesDataController: FoodEntriesDataController = {
        let controller = FoodEntriesDataController(cellIdentifier: foodEntryCellId, foodEntryViewModels: foodEntryViewModels)
        controller.delegate = self
        return controller
    }()
    
    lazy var foodEntriesTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.FoodEntriesTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = foodEntriesDataController
        tv.dataSource = foodEntriesDataController
        return tv
    }()
}

//MARK: Setup
extension ActionController {
    func setupFoodEntryViewModels(_ foodEntryViewModels: [FoodEntryViewModel]) {
        self.foodEntryViewModels = foodEntryViewModels
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(foodEntriesTableView)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        foodEntriesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        foodEntriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        foodEntriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        foodEntriesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Data controller deelgate
extension ActionController: FoodEntriesDataControllerDelegate {
    func rowSelected(at row: Int) {
        
    }
}

