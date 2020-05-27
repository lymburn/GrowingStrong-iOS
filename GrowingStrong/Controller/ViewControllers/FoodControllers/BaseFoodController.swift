//
//  BaseFoodController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-17.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class BaseFoodController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = foodEntryViewModel.food.name
        
        self.hideKeyboardWhenTappedAround()
        
        servingInfoTableView.register(ServingSizeSelectorCell.self, forCellReuseIdentifier: servingSizeSelectorCellIdentifier)
        servingInfoTableView.register(ServingAmountCell.self, forCellReuseIdentifier: servingAmountCellIdenfitier)

        setupViews()
        setupConstraints()
    }
    
    let servingAmountCellIdenfitier = "servingAmountCellIdentifier"
    let servingSizeSelectorCellIdentifier = "servingSizeSelectorCellIdentifier"
    var foodEntryViewModel: FoodEntryViewModel!
    var selectedServing: Serving!
    
    lazy var servingSizeOptionsLauncher: ServingSizeOptionsLauncher = {
        let launcher = ServingSizeOptionsLauncher()
        launcher.servingOptions = foodEntryViewModel.food.servings
        launcher.delegate = self
        return launcher
    }()
    
    lazy var macroNutrientsView: MacroNutrientsView = {
        let view = MacroNutrientsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.caloriesLabel.text = foodEntryViewModel.totalCaloriesText
        view.carbsLabel.text = foodEntryViewModel.totalCarbohydratesText
        view.fatLabel.text = foodEntryViewModel.totalFatText
        view.proteinLabel.text = foodEntryViewModel.totalProteinText
        return view
    }()
    
    lazy var baseFoodDataController: BaseFoodDataController = {
        let controller = BaseFoodDataController(servingAmountCellId: servingAmountCellIdenfitier, servingSizeOptionsCellId: servingSizeSelectorCellIdentifier, selectedServing: selectedServing)
        controller.delegate = self
        return controller
    }()
    
    lazy var servingInfoTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.servingInfoTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = baseFoodDataController
        tv.dataSource = baseFoodDataController
        return tv
    }()
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(macroNutrientsView)
        view.addSubview(servingInfoTableView)
    }
    
    func setupConstraints() {
        macroNutrientsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        macroNutrientsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        macroNutrientsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        macroNutrientsView.heightAnchor.constraint(equalToConstant: SizeConstants.screenSize.height * 0.3).isActive = true
        
        servingInfoTableView.topAnchor.constraint(equalTo: macroNutrientsView.bottomAnchor).isActive = true
        servingInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        servingInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        servingInfoTableView.heightAnchor.constraint(equalToConstant: SizeConstants.screenSize.height * 0.2).isActive = true
    }
}

//MARK: Helpers
extension BaseFoodController {
    fileprivate func setServingSizeValueLabel(servingSizeText: String) {
        let cell = servingInfoTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ServingSizeSelectorCell
        cell.servingSizeValueLabel.text = servingSizeText
    }
    
    fileprivate func updateMacroNutrientsView() {
        macroNutrientsView.caloriesLabel.text = foodEntryViewModel.totalCaloriesText
        macroNutrientsView.carbsLabel.text = foodEntryViewModel.totalCarbohydratesText
        macroNutrientsView.fatLabel.text = foodEntryViewModel.totalFatText
        macroNutrientsView.proteinLabel.text = foodEntryViewModel.totalProteinText
    }
}

//MARK: BaseFoodDataController delegate
extension BaseFoodController: BaseFoodDataControllerDelegate {
    func servingSizeSelectorCellSelected() {
        servingSizeOptionsLauncher.launchOptions(withDim: true)
    }
    
    func servingAmountCellSelected() {
        let cell = servingInfoTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ServingAmountCell
        cell.servingAmountValueTextField.becomeFirstResponder()
    }
    
    func servingAmountTextFieldDidEndEditing(_ servingAmount: Float) {
        foodEntryViewModel.servingAmount = servingAmount
        updateMacroNutrientsView()
    }
}

//MARK: ServingSizeOptionsLauncher delegate
extension BaseFoodController: ServingSizeOptionsLauncherDelegate {
    func didSelectOption(option: Serving) {
        setServingSizeValueLabel(servingSizeText: option.servingSize.toText())
        selectedServing = option
        foodEntryViewModel.selectedServing = selectedServing
        updateMacroNutrientsView()
    }
}
