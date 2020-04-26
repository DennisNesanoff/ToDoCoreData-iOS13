//
//  MainViewController.swift
//  ToDoCoreData-iOS13
//
//  Created by Dennis Nesanoff on 26.04.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {
    
    private let cellIdentifire = "Cell"
    private var tasks: [Task] = []
    // Managed object context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else { return }
            self.saveData(text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addTextField()
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func saveData(_ taskName: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        let task = NSManagedObject(entity: entity, insertInto: context) as! Task
        task.name = taskName
        
        do {
            try context.save()
            tasks.append(task)
            tableView.insertRows(at: [IndexPath(row: self.tasks.count - 1, section: 0)], with: .automatic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchData() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            tasks = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    /// Setup View
    private func setupView() {
        view.backgroundColor = UIColor(red: 99 / 255, green: 110 / 255, blue: 114 / 255, alpha: 1.0)
        setupNavigationBar()
    }
    
    /// Setup NavigationBar
    private func setupNavigationBar() {
        title = "Tasks list"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(red: 45 / 255, green: 52 / 255, blue: 54 / 255, alpha: 1.0)

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        
        // Add button to navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
    }
    
    @objc private func addNewTask() {
        showAlert(title: "New Task", message: "What will you make?")
    }
}

// MARK: - TableViewDataSource
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.backgroundColor = UIColor(red: 99 / 255, green: 110 / 255, blue: 114 / 255, alpha: 1.0)
        cell.textLabel?.textColor = .white
        return cell
    }
}

// MARK: - TableViewDelegate
extension MainViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
