//
//  CathegoryViewController.swift
//  ToDoCoreData-iOS13
//
//  Created by Dennis Nesanoff on 07.04.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit
import CoreData

class CathegoryViewController: UITableViewController {
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .blue, tintColor: .white, title: "ToDo list", preferredLargeTitle: true)
        
        loadCathegories()
    }
    
    @IBAction func addButtonItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new cathegory", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            let newCathegory = Category(context: self.context)
            newCathegory.name = textField.text!
            guard newCathegory.name != "" else { return }
            self.categories.append(newCathegory)
            
            self.saveCathegories()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new cathegory"
            
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CathegoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVS = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVS.selectedCategory = categories[indexPath.row]
        }
    }
    
    // MARK: - Data manipulation methods
    
    private func saveCathegories() {
        do { try context.save()}
        catch { print("Error saving conext, \(error)") }
        
        tableView.reloadData()
    }
    
    func loadCathegories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do { categories = try context.fetch(request) }
        catch { print("Error fetching data from context, \(error)") }
        tableView.reloadData()
    }
}
