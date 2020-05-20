//
//  ServingSizeOptionsLauncher.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-20.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol ServingSizeOptionsLauncherDelegate: class {
    func didSelectOption(option: ServingSize)
}

class ServingSizeOptionsLauncher: NSObject {
    override init() {
        super.init()
        
        servingSizeOptionsTableView.register(ServingSizeOptionsCell.self, forCellReuseIdentifier: servingSizeOptionsCellIdentifier)
    }
    
    let servingSizeOptionsCellIdentifier = "servingSizeOptionsCellIdentifier"
    var servingSizeOptions: [ServingSize]!
    var servingSizeOptionsTexts: [String]!
    
    weak var delegate: ServingSizeOptionsLauncherDelegate?
    
    lazy var servingSizeOptionsTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.ServingSizeOptionsLauncher.ServingSizeOptionsTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    let blackView = UIView()
    
    func launchOptions() {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOptions)))
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let height: CGFloat = SizeConstants.ScreenSize.height * 0.3
            let y = window.frame.height - height
            
            window.addSubview(servingSizeOptionsTableView)
            
            servingSizeOptionsTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.servingSizeOptionsTableView.frame = CGRect(x: 0, y: y, width: self.servingSizeOptionsTableView.frame.width, height: self.servingSizeOptionsTableView.frame.height)
                
            }, completion: nil)
        }
    }
    
    @objc func dismissOptions() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                self.servingSizeOptionsTableView.frame = CGRect(x: 0, y: window.frame.height, width: self.servingSizeOptionsTableView.frame.width, height: self.servingSizeOptionsTableView.frame.height)
            }
        })
    }
}

//MARK: Data source & delegate
extension ServingSizeOptionsLauncher: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servingSizeOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: servingSizeOptionsCellIdentifier, for: indexPath) as! ServingSizeOptionsCell
        cell.optionLabel.text = servingSizeOptions[indexPath.row].toText()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissOptions()
        delegate?.didSelectOption(option: servingSizeOptions[indexPath.row])
    }
}
