//
//  ChecklistItemTableViewCell.swift
//  Checklists
//
//  Created by Hung-Ching Song on 2019/3/20.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ChecklistItemTableViewCell: UITableViewCell, UITextFieldDelegate {
    var checklistItem: ChecklistItem!
    @IBOutlet var textFieldName: UITextField!
    @IBOutlet var switchIsChecked: UISwitch!
    
    func bind(_ checklistItem: ChecklistItem) {
        self.checklistItem = checklistItem
        textFieldName.text = checklistItem.name
        switchIsChecked.isOn = checklistItem.isChecked
    }
    
    @IBAction func toggleIsChecked(_ sender: UISwitch) {
        checklistItem.isChecked = !checklistItem.isChecked
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checklistItem.name = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
