//
//  Data.swift
//  Checklists
//
//  Created by Hung-Ching Song on 2019/3/20.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import CoreData

func loadChecklists() -> [Checklist] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    do {
        let fetchRequest: NSFetchRequest<Checklist> = Checklist.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        let checklists: [Checklist] = try managedContext.fetch(fetchRequest)
        return checklists
    } catch {
        preconditionFailure("Error: \(error)")
    }
}

func createChecklist(name: String?) -> Checklist {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let checklist = Checklist(context: managedContext)
    checklist.name = name
    checklist.dateCreated = Date()
    return checklist
}

func deleteChecklist(_ checklist: Checklist) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    managedContext.delete(checklist)
}

func createChecklistItem(name: String?, checklist: Checklist) -> ChecklistItem {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let checklistItem = ChecklistItem(context: managedContext)
    checklistItem.name = name
    checklistItem.isChecked = false
    checklistItem.dateCreated = Date()
    checklist.addToItems(checklistItem)
    return checklistItem
}

func deleteChecklistItem(_ checklistItem: ChecklistItem) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let checklist = checklistItem.checklist!
    checklist.removeFromItems(checklistItem)
    managedContext.delete(checklistItem)
}
