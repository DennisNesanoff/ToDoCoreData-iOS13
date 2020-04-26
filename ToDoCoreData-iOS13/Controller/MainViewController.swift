//
//  MainViewController.swift
//  ToDoCoreData-iOS13
//
//  Created by Dennis Nesanoff on 26.04.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let cellIdentifire = "Cell"
    private var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
    }
    
    /// Setup View
    private func setupView() {
        view.backgroundColor = .white
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
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - TableViewDataSource
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath)
        
        return cell
    }
}
