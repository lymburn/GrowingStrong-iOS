//
//  DiaryController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit
import CoreData

class DiaryController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let foodEntryNetworkManager = FoodEntryNetworkManager()
        let foodEntryNetworkHelper = FoodEntryNetworkHelper(foodEntryNetworkManager: foodEntryNetworkManager,
                                                            jwtTokenKey: KeyChainKeys.jwtToken)
        
        setupDependencies(dateBar: dBar,
                          dailyNutritionView: dnView,
                          foodEntryNetworkHelper: foodEntryNetworkHelper)
        setupViews()
        setupNotificationCenter()
        
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
    var currentDate: Date = Date()
    var foodEntryViewModels: [FoodEntryViewModel]! = FoodEntryDataManager.fetchFoodEntries()?.map { return FoodEntryViewModel(foodEntry: $0)}
    var dateBar: DateBarType!
    var dailyNutritionView: DailyNutritionViewType!
    var foodEntryNetworkHelper: FoodEntryNetworkHelperType!
    
    lazy var navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
    
    lazy var diaryFoodEntriesDataController: DiaryFoodEntriesDataController = {
        let controller = DiaryFoodEntriesDataController(cellIdentifier: foodEntryCellId,
                                                   foodEntryViewModels: getFoodEntryViewModelsByDate(foodEntryViewModels, currentDate))
        controller.diaryFoodEntriesDataControllerDelegate = self
        controller.baseFoodEntriesDataControllerDelegate = self
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
        tv.delegate = diaryFoodEntriesDataController
        tv.dataSource = diaryFoodEntriesDataController
        return tv
    }()
    
    lazy var dateFormatter: DateFormatter = DateFormatterHelper.generateDateFormatter(withFormat: DateFormatConstants.longMonthDefault)
}

//MARK: Setup
extension DiaryController {
    func setupDependencies (dateBar: DateBarType,
                            dailyNutritionView: DailyNutritionViewType,
                            foodEntryNetworkHelper: FoodEntryNetworkHelperType) {
        
        self.dateBar = dateBar
        self.dailyNutritionView = dailyNutritionView
        self.foodEntryNetworkHelper = foodEntryNetworkHelper
    }
    
    fileprivate func setupNotificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: CoreDataManager.shared.context)
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
    fileprivate func getFoodEntryViewModelsByDate(_ foodEntryViewModels: [FoodEntryViewModel], _ date: Date) -> [FoodEntryViewModel] {
        return foodEntryViewModels.filter({$0.dateAdded.isEqualTo(date: date, by: .day)})
    }
    
    fileprivate func updateFoodEntriesUI(for date: Date) {
        diaryFoodEntriesDataController.updateFoodEntryViewModels(getFoodEntryViewModelsByDate(foodEntryViewModels, date))
        foodEntriesTableView.reloadData()
    }
    
    fileprivate func updateFoodEntryViewModelsFromCoreData() {
        foodEntryViewModels = FoodEntryDataManager.fetchFoodEntries()?.map { return FoodEntryViewModel(foodEntry: $0)}
    }
}

//MARK: Date bar delegate
extension DiaryController: DateBarDelegate {
    func previousDatePressed() {
        let currentDateText = dateBar.getDateValue()
        let previousDateText = dateFormatter.getPreviousDateString(from: currentDateText)
        dateBar.setDateValue(text: previousDateText)
        
        if let previousDateText = previousDateText, let previousDate = dateFormatter.date(from: previousDateText) {
            currentDate = previousDate
            updateFoodEntriesUI(for: previousDate)
        }
    }
    
    func nextDatePressed() {
        let currentDateText = dateBar.getDateValue()
        let nextDateText = dateFormatter.getNextDateString(from: currentDateText)
        dateBar.setDateValue(text: nextDateText)
        
        if let nextDateText = nextDateText, let nextDate = dateFormatter.date(from: nextDateText) {
            currentDate = nextDate
            updateFoodEntriesUI(for: nextDate)
        }
    }
}

//MARK: Data controller delegate
extension DiaryController: DiaryFoodEntriesDataControllerDelegate {
    func rowDeleted(at row: Int) {
        let foodEntryViewModel = foodEntryViewModels[row]
        FoodEntryDataManager.deleteFoodEntry(foodEntryId: foodEntryViewModel.foodEntryId)
    }
}

extension DiaryController: BaseFoodEntriesDataControllerDelegate {
    func rowSelected(at row: Int) {
        let editFoodController = EditFoodController()
        let foodEntryVM = getFoodEntryViewModelsByDate(foodEntryViewModels, currentDate)[row]
        editFoodController.foodEntryViewModel = foodEntryVM
        editFoodController.selectedServing = foodEntryVM.selectedServing
        navigationController?.pushViewController(editFoodController, animated: true)
    }
}

//MARK: Notification center
extension DiaryController {
    @objc func managedObjectContextObjectsDidChange(notification: NSNotification) {
        //TODO: Network request to insert/update/delete food entry item
        
        guard let userInfo = notification.userInfo else { return }
        
        updateFoodEntryViewModelsFromCoreData()
        updateFoodEntriesUI(for: currentDate)
        
        if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, !inserts.isEmpty {
            print("Diary controller - inserted objects")
        }

        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>, !updates.isEmpty {
            for update in updates {
                if let foodEntry = update as? FoodEntry {
                    networkUpdateFoodEntry(foodEntry: foodEntry)
                }
            }
        }

        if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>, !deletes.isEmpty {
            for delete in deletes {
                if let foodEntry = delete as? FoodEntry {
                    networkDeleteFoodEntry(foodEntry: foodEntry)
                }
            }
        }
    }
    
    //Notification helpers
    
    //TODO: Handle errors
    fileprivate func networkUpdateFoodEntry(foodEntry: FoodEntry) {
        let foodEntryId = Int(foodEntry.foodEntryId)
        let parameters = foodEntry.generateUpdateParameters()
        guard let header = JWTHeaderGenerator.generateHeader(jwtTokenKey: KeyChainKeys.jwtToken) else { return }
        
        foodEntryNetworkHelper.updateFoodEntry(foodEntryId: foodEntryId, bodyParameters: parameters, headers: header) { response in
            switch response {
            case .success:
                print("Successfully updated food entry")
            case .networkError:
                print("Error updating food entry")
            }
        }
    }
    
    //TODO: Handle errors
    fileprivate func networkDeleteFoodEntry(foodEntry: FoodEntry) {
        let foodEntryId = Int(foodEntry.foodEntryId)
        guard let header = JWTHeaderGenerator.generateHeader(jwtTokenKey: KeyChainKeys.jwtToken) else { return }
        
        foodEntryNetworkHelper.deleteFoodEntry(foodEntryId: foodEntryId, headers: header) { response in
            switch response {
            case .success:
                print("Successfully deleted food entry")
            case .networkError:
                print("Error deleting food entry")
            }
        }
    }
}
