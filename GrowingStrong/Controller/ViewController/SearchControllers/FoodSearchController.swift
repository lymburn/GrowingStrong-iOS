//
//  FoodSearchController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-27.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class FoodSearchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodEntryViewModels = []
        setupSearchController()
        setupNavigationItems()
        setupFoodEntryViewModels(foodEntryViewModels)
        foodEntriesTableView.register(FoodCell.self, forCellReuseIdentifier: foodEntryCellId)
        
        setupViews()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var foodEntryViewModels: [FoodEntryViewModel]!
    let foodEntryCellId = "foodEntryCellId"
    
    var filteredFoodEntryViewModels: [FoodEntryViewModel] = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    lazy var searchFoodEntriesDataController: SearchFoodEntriesDataController = {
        let controller = SearchFoodEntriesDataController(cellIdentifier: foodEntryCellId, foodEntryViewModels: foodEntryViewModels)
        controller.baseFoodEntriesDataControllerDelegate = self
        return controller
    }()
    
    lazy var foodEntriesTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.foodEntriesTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = searchFoodEntriesDataController
        tv.dataSource = searchFoodEntriesDataController
        return tv
    }()
}

//MARK: Setup
extension FoodSearchController {
    func setupFoodEntryViewModels(_ foodEntryViewModels: [FoodEntryViewModel]) {
        self.foodEntryViewModels = foodEntryViewModels
    }
    
    fileprivate func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Food"
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Add Food"
        navigationItem.searchController = searchController
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

//MARK: Data controller delegate
extension FoodSearchController: BaseFoodEntriesDataControllerDelegate {
    func rowSelected(at row: Int) {
        let addFoodController = AddFoodController()
        let foodEntryVM = foodEntryViewModels[row]
        addFoodController.foodEntryViewModel = foodEntryVM
        addFoodController.selectedServing = foodEntryVM.selectedServing
        navigationController?.pushViewController(addFoodController, animated: true)
    }
}

//MARK: Search results updating protocol
extension FoodSearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

//MARK: Searching & filtering functionality
extension FoodSearchController {
    func filterContentForSearchText(_ searchText: String) {
        filteredFoodEntryViewModels = foodEntryViewModels.filter { (foodEntryViewModel: FoodEntryViewModel) -> Bool in
            return foodEntryViewModel.food.foodName.lowercased().contains(searchText.lowercased())
        }
        
        if isFiltering {
            searchFoodEntriesDataController.updateFoodEntryViewModels(filteredFoodEntryViewModels)
        } else {
            searchFoodEntriesDataController.updateFoodEntryViewModels(foodEntryViewModels)
        }
        
        foodEntriesTableView.reloadData()
    }
}
