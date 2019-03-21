//
//  ViewController.swift
//  Checklists
//
//  Created by Hung-Ching Song on 2019/3/20.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import CoreData

class ChecklistsViewController: UITableViewController {
    private var mostRecentSelectedIndexPath: IndexPath?
    private var checklists: [Checklist]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checklists = loadChecklists()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = mostRecentSelectedIndexPath {
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
            mostRecentSelectedIndexPath = nil
        }
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Checklist", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        if let textField = alertController.textFields?.first {
            textField.placeholder = "Name (Optional)"
            textField.autocapitalizationType = .sentences
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Submit", style: .default) {
            action in
            let textFieldName = alertController.textFields!.first!
            let checklist = createChecklist(name: textFieldName.text)
            self.checklists.insert(checklist, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChecklist" {
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            mostRecentSelectedIndexPath = selectedIndexPath
            let index = selectedIndexPath.row
            let checklistViewController = segue.destination as! ChecklistViewController
            checklistViewController.checklist = checklists[index]
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let checklistTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChecklistTableViewCell", for: indexPath) as! ChecklistTableViewCell
        checklistTableViewCell.bind(checklists[indexPath.row])
        return checklistTableViewCell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            deleteChecklist(checklists[index])
            checklists.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
