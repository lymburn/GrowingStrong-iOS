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
        
        setupSearchController()
        setupNavigationItems()
        foodEntriesTableView.register(FoodCell.self, forCellReuseIdentifier: foodEntryCellId)
        
        let foodNetworkManager = FoodNetworkManager(persistentContainer: CoreDataManager.shared.persistentContainer,
                                                    managedObjectContext: CoreDataManager.shared.backgroundContext)
        let foodNetworkHelper = FoodNetworkHelper(foodNetworkManager: foodNetworkManager, jwtTokenKey: KeyChainKeys.jwtToken)
        
        setupDependencies(foodNetworkHelper: foodNetworkHelper)
        
        setupViews()
        
        navigationItem.leftBarButtonItem = backButton
    }

    let searchController = UISearchController(searchResultsController: nil)
    
    var foodEntryViewModels: [FoodEntryViewModel] = []
    let foodEntryCellId = "foodEntryCellId"
    
    
    var foodNetworkHelper: FoodNetworkHelperType!
    
    lazy var backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
    
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
    fileprivate func setupSearchController() {
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
                self.foodEntryViewModels = getFoodEntryViewModelsFromFoods(foods: foods)
                updateFoodEntryViewModels(foodEntryViewModels: foodEntryViewModels)
                updateUI()
            }
        }
    }
    
    fileprivate func getFoodEntryViewModelsFromFoods(foods: [Food]) -> [FoodEntryViewModel]{
        let foodEntryViewModels = foods.map { return FoodEntryViewModel(food: $0,
                                                                        dateAdded: CurrentDiaryDateTracker.shared.currentDate,
                                                                        selectedServing: $0.servings.first!,
                                                                        servingAmount: 1) }
        
        return foodEntryViewModels
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

//MARK: Touch events
extension FoodSearchController {
    @objc func backTapped() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
