//
//  DiaryController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

let testServingSizes1: [ServingSize] = [
    ServingSize(quantity: 100, unit: "g"),
    ServingSize(quantity: 10, unit: "g"),
]

let testServingSizes2: [ServingSize] = [
    ServingSize(quantity: 1.5, unit: "lb"),
    ServingSize(quantity: 4, unit: "ounce")
]

let testServings1: [Serving] = [
    Serving(caloriesPerServing: 1500, carbohydratesPerServing: 10, fatPerServing: 20.3, proteinPerServing: 40.6, servingSize: testServingSizes1[0]),
    Serving(caloriesPerServing: 150, carbohydratesPerServing: 1, fatPerServing: 2.03, proteinPerServing: 4.06, servingSize: testServingSizes1[1])
]

let testServings2: [Serving] = [
    Serving(caloriesPerServing: 1000, carbohydratesPerServing: 50, fatPerServing: 30, proteinPerServing: 20, servingSize: testServingSizes2[0]),
    Serving(caloriesPerServing: 200, carbohydratesPerServing: 15, fatPerServing: 10, proteinPerServing: 5, servingSize: testServingSizes2[1])
]

let testFoods: [Food] = [
    Food(id: 1, name: "Turkey", servings: testServings1),
    Food(id: 2, name: "Chicken", servings: testServings2)
]

let testFoodEntries: [FoodEntry] = [
    FoodEntry(id: 1, food: testFoods[0], selectedServing: testServings1[0], servingAmount: 1, dateAdded: Date()),
    FoodEntry(id: 2, food: testFoods[1], selectedServing: testServings2[0], servingAmount: 1, dateAdded: Date())
]

class DiaryController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDateBar(dBar)
        setupDailyNutritionView(dnView)
        setupFoodEntryViewModels(testFoodEntries.map({return FoodEntryViewModel.init(foodEntry: $0)}))
        setupViews()
        
        foodEntriesTableView.register(FoodCell.self, forCellReuseIdentifier: foodEntryCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let tabBarController = self.tabBarController as? MainTabBarController
        tabBarController?.showTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    let foodEntryCellId = "foodEntryCellId"
    
    var testFoodEntryViewModels: [FoodEntryViewModel]!
    var dateBar: DateBarType!
    var dailyNutritionView: DailyNutritionViewType!
    
    lazy var navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
    
    lazy var foodEntriesDataController: FoodEntriesDataController = {
        let controller = FoodEntriesDataController(cellIdentifier: foodEntryCellId, foodEntryViewModels: getFoodEntriesByDate(testFoodEntryViewModels, Date()))
        controller.delegate = self
        return controller
    }()
    
    lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: navBarHeight))
        navBar.isTranslucent = true
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.backgroundColor = .green
        return navBar
    }()
    
    lazy var dBar: DateBar = {
        let bar = DateBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.setDateValue(text: dateFormatter.getCurrentDateString())
        bar.delegate = self
        return bar
    }()
    
    let dnView: DailyNutritionView = {
        let view = DailyNutritionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var foodEntriesTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.foodEntriesTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = foodEntriesDataController
        tv.dataSource = foodEntriesDataController
        return tv
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatConstants.longMonthDefault
        return df
    }()
}

//MARK: Setup
extension DiaryController {
    func setupDateBar(_ dateBar: DateBarType) {
        self.dateBar = dateBar
    }
    
    func setupDailyNutritionView(_ dailyNutritionView: DailyNutritionViewType) {
        self.dailyNutritionView = dailyNutritionView
    }
    
    func setupFoodEntryViewModels(_ foodEntryViewModels: [FoodEntryViewModel]) {
        self.testFoodEntryViewModels = foodEntryViewModels
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(navBar)
        view.addSubview(dateBar)
        view.addSubview(dailyNutritionView)
        view.addSubview(foodEntriesTableView)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        dateBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dateBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dateBar.heightAnchor.constraint(equalToConstant: navBarHeight).isActive = true
        
        dailyNutritionView.topAnchor.constraint(equalTo: dateBar.bottomAnchor).isActive = true
        dailyNutritionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dailyNutritionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dailyNutritionView.heightAnchor.constraint(equalToConstant: SizeConstants.screenSize.height * 0.25).isActive = true
        
        foodEntriesTableView.topAnchor.constraint(equalTo: dailyNutritionView.bottomAnchor).isActive = true
        foodEntriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        foodEntriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        foodEntriesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Helpers
extension DiaryController {
    fileprivate func getFoodEntriesByDate(_ foodEntryViewModels: [FoodEntryViewModel], _ date: Date) -> [FoodEntryViewModel] {
        return foodEntryViewModels.filter({$0.dateAdded.isEqualTo(date: date, by: .day)})
    }
    
    fileprivate func updateFoodEntriesUI(for date: Date) {
        foodEntriesDataController.updateFoodEntryViewModels(getFoodEntriesByDate(testFoodEntryViewModels, date))
        foodEntriesTableView.reloadData()
    }
}

//MARK: Date bar delegate
extension DiaryController: DateBarDelegate {
    func previousDatePressed() {
        let currentDateText = dateBar.getDateValue()
        let previousDateText = dateFormatter.getPreviousDateString(from: currentDateText)
        dateBar.setDateValue(text: previousDateText)
        
        if let previousDateText = previousDateText, let previousDate = dateFormatter.date(from: previousDateText) {
            updateFoodEntriesUI(for: previousDate)
        }
    }
    
    func nextDatePressed() {
        let currentDateText = dateBar.getDateValue()
        let nextDateText = dateFormatter.getNextDateString(from: currentDateText)
        dateBar.setDateValue(text: nextDateText)
        
        if let nextDateText = nextDateText, let nextDate = dateFormatter.date(from: nextDateText) {
            updateFoodEntriesUI(for: nextDate)
        }
    }
}

//MARK: Data controller delegate
extension DiaryController: FoodEntriesDataControllerDelegate {
    func rowSelected(at row: Int) {
        let editFoodController = EditFoodController()
        let foodEntryVM = testFoodEntryViewModels[row]
        editFoodController.foodEntryViewModel = foodEntryVM
        editFoodController.selectedServing = foodEntryVM.selectedServing
        navigationController?.pushViewController(editFoodController, animated: true)
    }
}
