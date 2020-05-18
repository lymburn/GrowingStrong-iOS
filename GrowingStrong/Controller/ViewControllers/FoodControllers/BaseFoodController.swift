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
        
        setupViews()
    }
    
    lazy var macroNutrientsView: MacroNutrientsView = {
        let view = MacroNutrientsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.caloriesLabel.text = foodViewModel.totalCaloriesText
        view.carbsLabel.text = foodViewModel.totalCarbohydratesText
        view.fatLabel.text = foodViewModel.totalFatText
        view.proteinLabel.text = foodViewModel.totalProteinText
        return view
    }()
    
    lazy var servingInfoTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.FoodController.ServingInfoTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        return tv
    }()
    
    var foodViewModel: FoodViewModel!
}

//MARK: Setup
extension BaseFoodController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(macroNutrientsView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        macroNutrientsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        macroNutrientsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        macroNutrientsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
