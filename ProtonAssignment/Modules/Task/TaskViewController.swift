//
//  TaskViewController.swift
//  ProtonAssignment
//
//  Created by azerty on 07/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable

final class TaskViewController: UIViewController, StoryboardBased {
    // MARK:- IBOutlet
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK:- Properties
    fileprivate var task = ["foo", "toto", "blabla"]
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View setup
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(cellType: TaskTableViewCell.self)
    }
}

// MARK:- TableView Delegate & DataSource extension
extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView.dequeueReusableCell(for: indexPath) as TaskTableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
}
