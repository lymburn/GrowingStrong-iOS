//
//  File.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-11.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    let registerStatsView: RegisterStatsView = {
        let view = RegisterStatsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension RegisterController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(registerStatsView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        registerStatsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        registerStatsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        registerStatsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        registerStatsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
