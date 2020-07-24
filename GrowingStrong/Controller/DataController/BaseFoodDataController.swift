//
//  BaseFoodDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-18.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol BaseFoodDataControllerDelegate: class {
    func servingSizeSelectorCellSelected()
    func servingAmountCellSelected()
    func servingAmountTextFieldDidEndEditing(_ servingAmount: Float)
}

class BaseFoodDataController: NSObject, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    private var servingAmountCellId: String
    private var servingSizeSelectorCellId: String
    private var selectedServing: Serving
    private var servingAmount: Float
    
    weak var delegate: BaseFoodDataControllerDelegate?
    
    init(servingAmountCellId: String, servingSizeOptionsCellId: String, servingAmount: Float, selectedServing: Serving) {
        self.servingAmountCellId = servingAmountCellId
        self.servingSizeSelectorCellId = servingSizeOptionsCellId
        self.servingAmount = servingAmount
        self.selectedServing = selectedServing
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let servingSizeSelectorCell = tableView.dequeueReusableCell(withIdentifier: servingSizeSelectorCellId, for: indexPath) as! ServingSizeSelectorCell
            servingSizeSelectorCell.servingSizeValueLabel.text = selectedServing.getServingSizeText()
            return servingSizeSelectorCell
        } else {
            let servingAmountCell = tableView.dequeueReusableCell(withIdentifier: servingAmountCellId, for: indexPath) as! ServingAmountCell
            servingAmountCell.servingAmountValueTextField.text = servingAmount.clean
            servingAmountCell.servingAmountValueTextField.delegate = self
            return servingAmountCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            delegate?.servingSizeSelectorCellSelected()
        } else {
            delegate?.servingAmountCellSelected()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let servingAmountText = textField.text {
            let servingAmount = Float(servingAmountText)!
            delegate?.servingAmountTextFieldDidEndEditing(servingAmount)
        }
    }
}
