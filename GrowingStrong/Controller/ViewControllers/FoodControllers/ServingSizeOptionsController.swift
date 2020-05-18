//
//  ServingSizeOptionsController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-18.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class ServingSizeOptionsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        servingSizeTableView.register(ServingSizeOptionCell.self, forCellReuseIdentifier: cellIdentifier)
        
        setupViews()
    }
    
    var cellIdentifier = "servingSizeOptionsCellIdentifier"
    var servingSizeOptions: [String]!
    
    lazy var servingSizeTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.ServingSizeController.ServingSizeTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
}

//MARK: Setup
extension ServingSizeOptionsController {
    fileprivate func setupViews() {
        view.addSubview(servingSizeTableView)
        view.isOpaque = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        servingSizeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SizeConstants.ScreenSize.width * 0.1).isActive = true
        servingSizeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SizeConstants.ScreenSize.width * 0.1).isActive = true
        servingSizeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SizeConstants.ScreenSize.height * 0.3).isActive = true
        servingSizeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SizeConstants.ScreenSize.height * 0.3).isActive = true
    }
}

//MARK: Delegate & datasource
extension ServingSizeOptionsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servingSizeOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ServingSizeOptionCell
        cell.optionLabel.text = servingSizeOptions[indexPath.row]
        return cell
    }
}
