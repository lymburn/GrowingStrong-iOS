//
//  DiaryController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

let testFoods: [Food] = [
    Food(id: 1, name: "Turkey", servingSizeQuantity: 100, servingSizeUnit: ServingSizeUnit.gram.rawValue, servingAmount: 5, caloriesPerServing: 200, carbohydratesPerServing: 8.5, fatPerServing: 15.4, proteinPerServing: 30.5),
    Food(id: 2, name: "Chicken", servingSizeQuantity: 1.5, servingSizeUnit: ServingSizeUnit.pound.rawValue, servingAmount: 1, caloriesPerServing: 1500, carbohydratesPerServing: 10, fatPerServing: 20.3, proteinPerServing: 40.6)
]

class DiaryController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDateBar(dBar)
        self.testFoodViewModels = testFoods.map({return FoodViewModel.init(food: $0)})
        setupDailyNutritionView(dnView)
        setupViews()
        
        tableView.register(FoodCell.self, forCellReuseIdentifier: foodCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    let foodCellId = "foodCell"
    
    var testFoodViewModels: [FoodViewModel]!
    var dateBar: DateBarType!
    var dailyNutritionView: DailyNutritionViewType!
    
    lazy var navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
    
    lazy var diaryDataController: DiaryDataController = {
        let controller = DiaryDataController(cellIdentifier: foodCellId, foodViewModels: testFoodViewModels)
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
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.DiaryView.FoodTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = diaryDataController
        tv.dataSource = diaryDataController
        return tv
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
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
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(navBar)
        view.addSubview(dateBar)
        view.addSubview(dailyNutritionView)
        view.addSubview(tableView)
        
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
        dailyNutritionView.heightAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.height * 0.25).isActive = true
        
        tableView.topAnchor.constraint(equalTo: dailyNutritionView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Date bar delegate
extension DiaryController: DateBarDelegate {
    func previousDatePressed() {
        let currentDateText = dateBar.getDateValue()
        let previousDateText = dateFormatter.getPreviousDateString(from: currentDateText)
        dateBar.setDateValue(text: previousDateText)
    }
    
    func nextDatePressed() {
        let currentDateText = dateBar.getDateValue()
        let nextDateText = dateFormatter.getNextDateString(from: currentDateText)
        dateBar.setDateValue(text: nextDateText)
    }
}

//MARK: Data controller delegate
extension DiaryController: DiaryDataControllerDelegate {
    func rowSelected(at row: Int) {
        let editFoodController = EditFoodController()
        editFoodController.foodViewModel = testFoodViewModels[row]
        navigationController?.pushViewController(editFoodController, animated: true)
    }
}
