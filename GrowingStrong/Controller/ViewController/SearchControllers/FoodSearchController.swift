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
        
        let foodNetworkManager = FoodNetworkManager(persistentContainer: CoreDataManager.shared.persistentContainer)
        let foodNetworkHelper = FoodNetworkHelper(foodNetworkManager: foodNetworkManager, jwtTokenKey: KeyChainKeys.jwtToken)
        
        setupDependencies(foodNetworkHelper: foodNetworkHelper)
        
        setupViews()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var foodEntryViewModels: [FoodEntryViewModel]!
    let foodEntryCellId = "foodEntryCellId"
    
    var filteredFoodEntryViewModels: [FoodEntryViewModel] = []
    
    var foodNetworkHelper: FoodNetworkHelperType!
    
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
        searchController.searchBar.delegate = self
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Add Food"
        navigationItem.searchController = searchController
    }
    
    fileprivate func setupDependencies(foodNetworkHelper: FoodNetworkHelperType) {
        self.foodNetworkHelper = foodNetworkHelper
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

extension FoodSearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        retrieveFoods(by: searchBar.text!)
    }
}

//MARK: Network searching helpers
extension FoodSearchController {
    fileprivate func retrieveFoods(by searchText: String) {
        let urlParameters = ["query" : searchText]
        guard let header = JWTHeaderGenerator.generateHeader(jwtTokenKey: KeyChainKeys.jwtToken) else { return }
        
        foodNetworkHelper.getFoodsByFullTextSearch(urlParameters: urlParameters, headers: header) { response, foods in
            self.handleSearchResponse(response: response, foods: foods)
        }
    }
    
    fileprivate func handleSearchResponse(response: FoodNetworkHelperResponse, foods: [Food]?) {
        //TODO: Handle these
        switch response {
        case .invalidQueryText:
            print ("Invalid search text")
        case .networkError:
            print ("Network error")
        case .success:
            if let foods = foods {
                let foodEntryViewModels = foods.map { return FoodEntryViewModel(food: $0) }
                updateFoodEntryViewModels(foodEntryViewModels: foodEntryViewModels)
                updateUI()
            }
        }
    }
    
    fileprivate func updateFoodEntryViewModels(foodEntryViewModels: [FoodEntryViewModel]) {
        self.foodEntryViewModels = foodEntryViewModels
        self.searchFoodEntriesDataController.updateFoodEntryViewModels(foodEntryViewModels)
    }
    
    fileprivate func updateUI() {
        DispatchQueue.main.async {
            self.foodEntriesTableView.reloadData()
        }
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
