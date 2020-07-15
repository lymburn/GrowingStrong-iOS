//
//  ServingSizeOptionsLauncher.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-20.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol ServingSizeOptionsLauncherDelegate: class {
    func didSelectOption(option: Serving)
}

class ServingSizeOptionsLauncher: BaseOptionsLauncher {
    override init() {
        super.init()
        
        servingSizeOptionsTableView.register(ServingSizeOptionsCell.self, forCellReuseIdentifier: servingSizeOptionsCellIdentifier)
    }
    
    let servingSizeOptionsCellIdentifier = "servingSizeOptionsCellIdentifier"
    var servingOptions: [Serving]!
    
    weak var delegate: ServingSizeOptionsLauncherDelegate?
    
    lazy var servingSizeOptionsTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.servingSizeOptionsTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func launchOptions(withDim: Bool) {
        super.launchOptions(withDim: withDim)
        displayServingSizeOptionsTableView()
    }
    
    private func displayServingSizeOptionsTableView() {
        if let window = window {
            let height: CGFloat = SizeConstants.screenSize.height * 0.3
            let y = window.frame.height - height
            
            window.addSubview(servingSizeOptionsTableView)
            
            servingSizeOptionsTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.servingSizeOptionsTableView.frame = CGRect(x: 0, y: y, width: self.servingSizeOptionsTableView.frame.width, height: self.servingSizeOptionsTableView.frame.height)
                
            }, completion: nil)
        }
    }
    
    private func dismissServingSizeOptionsTableView() {
        UIView.animate(withDuration: 0.5, animations: {
             if let window = self.window {
                 self.servingSizeOptionsTableView.frame = CGRect(x: 0, y: window.frame.height, width: self.servingSizeOptionsTableView.frame.width, height: self.servingSizeOptionsTableView.frame.height)
             }
         })
    }

    @objc override func dismissOptions() {
        super.dismissOptions()
        dismissServingSizeOptionsTableView()
    }
}

//MARK: Data source & delegate
extension ServingSizeOptionsLauncher: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: servingSizeOptionsCellIdentifier, for: indexPath) as! ServingSizeOptionsCell
        cell.optionLabel.text = servingOptions[indexPath.row].getServingSizeText()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissOptions()
        delegate?.didSelectOption(option: servingOptions[indexPath.row])
    }
}
