//
//  SettingOptionsLauncher.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-20.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol StandardOptionsLauncherDelegate: class {
    func didSelectOptionAtIndex(index: Int, option: String)
}

//Standard launcher for options with just a name in the cell
class StandardOptionsLauncher: BaseOptionsLauncher {
    override init() {
        super.init()
        
        standardOptionsTableView.register(StandardOptionCell.self, forCellReuseIdentifier: standardOptionCellIdentifier)
    }
    
    let standardOptionCellIdentifier = "standardOptionCellIdentifier"
    var options: [String] = [] {
        didSet {
            standardOptionsTableView.reloadData()
        }
    }
    
    weak var delegate: StandardOptionsLauncherDelegate?
    
    lazy var standardOptionsTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.optionsTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func launchOptions(withDim: Bool) {
        super.launchOptions(withDim: withDim)
        displayOptionsTableView()
    }
    
    private func displayOptionsTableView() {
        if let window = window {
            let height: CGFloat = standardOptionsTableView.rowHeight * CGFloat(options.count) + window.safeAreaInsets.bottom 
            let y = window.frame.height - height
            
            window.addSubview(standardOptionsTableView)
            
            standardOptionsTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.standardOptionsTableView.frame = CGRect(x: 0, y: y, width: self.standardOptionsTableView.frame.width, height: self.standardOptionsTableView.frame.height)
                
            }, completion: nil)
        }
    }
    
    private func dismissOptionsTableView() {
        UIView.animate(withDuration: 0.5, animations: {
             if let window = self.window {
                 self.standardOptionsTableView.frame = CGRect(x: 0, y: window.frame.height, width: self.standardOptionsTableView.frame.width, height: self.standardOptionsTableView.frame.height)
             }
         })
    }

    @objc override func dismissOptions() {
        super.dismissOptions()
        dismissOptionsTableView()
    }
}

//MARK: Data source & delegate
extension StandardOptionsLauncher: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: standardOptionCellIdentifier, for: indexPath) as! StandardOptionCell
        cell.optionLabel.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissOptions()
        delegate?.didSelectOptionAtIndex(index: indexPath.row, option: options[indexPath.row])
    }
}
