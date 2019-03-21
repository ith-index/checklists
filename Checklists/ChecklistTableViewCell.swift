//
//  ChecklistTableViewCell.swift
//  Checklists
//
//  Created by Hung-Ching Song on 2019/3/20.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ChecklistTableViewCell : UITableViewCell, UITextFieldDelegate {
    private var checklist: Checklist!
    @IBOutlet var textFieldName: UITextField!
    @IBOutlet var labelItemsCount: UILabel!
    
    func bind(_ checklist: Checklist) {
        self.checklist = checklist
        let checklistItems = checklist.items?.allObjects as? [ChecklistItem] ?? [ChecklistItem]()
        let isCheckedCount = checklistItems.filter {
            checklistItem in checklistItem.isChecked
        }.count
        textFieldName.text = checklist.name
        labelItemsCount.text = "\(isCheckedCount) / \(checklistItems.count)"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checklist.name = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
