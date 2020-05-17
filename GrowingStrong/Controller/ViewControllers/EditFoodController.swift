//
//  EditFoodController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-17.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class EditFoodController: UIViewController {

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
    
    var foodViewModel: FoodViewModel!
}

//MARK: Setup
extension EditFoodController {
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
