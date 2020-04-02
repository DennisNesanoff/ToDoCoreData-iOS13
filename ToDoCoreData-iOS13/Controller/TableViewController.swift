//
//  TableViewController.swift
//  ToDoCoreData-iOS13
//
//  Created by Dennis Nesanoff on 29.03.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    var itemArr = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newItem = Item()
        newItem.title = "Find Mike"
        itemArr.append(newItem)
        
//        if let items = userDefaults.array(forKey: "ToDoList") as? [String] {
//            itemArr = items
//        }
    }

    // MARK: - tableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = itemArr[indexPath.row].title

        if itemArr[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // MARK: - tableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArr[indexPath.row])
        
        if itemArr[indexPath.row].done == false {
            itemArr[indexPath.row].done = true
        } else {
            itemArr[indexPath.row].done = false
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArr.append(newItem)
            self.userDefaults.set(self.itemArr, forKey: "ToDoList")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
