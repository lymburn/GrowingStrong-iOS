//
//  DiaryController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class DiaryController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDateBar(dBar)
        setupViews()
    }
    
    var dateBar: DateBarType!
    
    lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navBar.isTranslucent = true
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.backgroundColor = .green
        return navBar
    }()
    
    lazy var dBar: DateBar = {
        let bar = DateBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.delegate = self
        return bar
    }()
    
    let dailyNutritionView: DailyNutritionView = {
        let view = DailyNutritionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(navBar)
        view.addSubview(dateBar)
        view.addSubview(dailyNutritionView)
        
        dateBar.setDateValue(text: dateFormatter.getCurrentDateString())
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        dateBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dateBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dateBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
