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
        navigationItem.title = foodViewModel.name
        
        self.hideKeyboardWhenTappedAround()
        
        servingInfoTableView.register(ServingSizeSelectorCell.self, forCellReuseIdentifier: servingSizeSelectorCellIdentifier)
        servingInfoTableView.register(ServingAmountCell.self, forCellReuseIdentifier: servingAmountCellIdenfitier)

        setupViews()
        setupConstraints()
    }
    
    let servingAmountCellIdenfitier = "servingAmountCellIdentifier"
    let servingSizeSelectorCellIdentifier = "servingSizeSelectorCellIdentifier"
    var foodViewModel: FoodViewModel!
    var selectedServingSize: ServingSize!
    
    lazy var servingSizeOptionsLauncher: ServingSizeOptionsLauncher = {
        let launcher = ServingSizeOptionsLauncher()
        launcher.delegate = self
        return launcher
    }()
    
    lazy var macroNutrientsView: MacroNutrientsView = {
        let view = MacroNutrientsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.caloriesLabel.text = foodViewModel.totalCaloriesText
        view.carbsLabel.text = foodViewModel.totalCarbohydratesText
        view.fatLabel.text = foodViewModel.totalFatText
        view.proteinLabel.text = foodViewModel.totalProteinText
        return view
    }()
    
    lazy var baseFoodDataController: BaseFoodDataController = {
        let controller = BaseFoodDataController(servingAmountCellId: servingAmountCellIdenfitier, servingSizeOptionsCellId: servingSizeSelectorCellIdentifier, selectedServingSize: selectedServingSize)
        controller.delegate = self
        return controller
    }()
    
    lazy var servingInfoTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.FoodController.ServingInfoTableViewRowHeight
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
        macroNutrientsView.heightAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.height * 0.3).isActive = true
        
        servingInfoTableView.topAnchor.constraint(equalTo: macroNutrientsView.bottomAnchor).isActive = true
        servingInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        servingInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        servingInfoTableView.heightAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.height * 0.2).isActive = true
    }
}

//MARK: Helpers
extension BaseFoodController {
    fileprivate func setServingSizeValueLabel(servingSizeText: String) {
        let cell = servingInfoTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ServingSizeSelectorCell
        cell.servingSizeValueLabel.text = servingSizeText
    }
}

//MARK: BaseFoodDataController delegate
extension BaseFoodController: BaseFoodDataControllerDelegate {
    func servingSizeSelectorCellSelected() {
        servingSizeOptionsLauncher.servingSizeOptions = foodViewModel.servingSizes
        servingSizeOptionsLauncher.launchOptions()
    }
    
    func servingAmountCellSelected() {
        let cell = servingInfoTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ServingAmountCell
        cell.servingAmountValueTextField.becomeFirstResponder()
    }
}

//MARK: ServingSizeOptionsLauncher delegate
extension BaseFoodController: ServingSizeOptionsLauncherDelegate {
    func didSelectOption(option: ServingSize) {
        setServingSizeValueLabel(servingSizeText: option.toText())
        selectedServingSize = option
    }
}
