//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Hung-Ching Song on 2019/3/20.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    var checklist: Checklist!
    var checklistItems: [ChecklistItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checklistItems = checklist.items?.allObjects as? [ChecklistItem] ?? [ChecklistItem]()
        checklistItems.sort {
            checklistItem1, checklistItem2 in
            return checklistItem1.dateCreated!.compare(checklistItem2.dateCreated!).rawValue == 1
        }
        navigationItem.title = checklist.name
        navigationItem.rightBarButtonItems = [navigationItem.rightBarButtonItem!, editButtonItem]
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New Checklist Item", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        if let textField = alertController.textFields?.first {
            textField.placeholder = "Name (Optional)"
            textField.autocapitalizationType = .sentences
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Submit", style: .default) {
            action in
            let textFieldName = alertController.textFields!.first!
            let checklistItem = createChecklistItem(name: textFieldName.text, checklist: self.checklist)
            self.checklistItems.insert(checklistItem, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklistItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let checklistItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItemTableViewCell", for: indexPath) as! ChecklistItemTableViewCell
        checklistItemTableViewCell.bind(checklistItems[indexPath.row])
        return checklistItemTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            deleteChecklistItem(checklistItems[index])
            checklistItems.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
