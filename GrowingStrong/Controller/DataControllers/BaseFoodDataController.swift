//
//  BaseFoodDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-18.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class BaseFoodDataController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var servingAmountCellId: String
    var servingSizeOptionsCellId: String
    
    init(servingAmountCellId: String, servingSizeOptionsCellId: String) {
        self.servingAmountCellId = servingAmountCellId
        self.servingSizeOptionsCellId = servingSizeOptionsCellId
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.item == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: servingSizeOptionsCellId, for: indexPath) as! ServingSizeOptionsCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: servingAmountCellId, for: indexPath) as! ServingAmountCell
        }
        
        return cell
    }
}
