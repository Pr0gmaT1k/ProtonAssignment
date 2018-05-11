//
//  CompletedTaskViewController.swift
//  ProtonAssignment
//
//  Created by azerty on 07/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift

/** Information Controller who display task execution history */
final class CompletedTaskViewController: UIViewController, StoryboardBased {
    // MARK:- IBOutlet
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var emptyLabel: UILabel!
    
    // MARK:- Properties
    fileprivate var tasks = [Task]() {
        didSet { self.tableView.isHidden = tasks.isEmpty }
    }
    fileprivate var notificationToken: NotificationToken?
    fileprivate let realm = Realm.safeInstance()
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View setup
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(cellType: CompletedTaskTableViewCell.self)
        
        // Empty label
        self.emptyLabel.text = L10n.completedTaskEmpty
        
        // Realm
        let tasksResults = realm.objects(Task.self)
        self.tasks = tasksResults.filter { $0.state == .canceled || $0.state == .failed || $0.state == .success }
        notificationToken = tasksResults.observe {[weak self] (changes: RealmCollectionChange) in
            guard let newTasks = self?.realm.objects(Task.self) else { return }
            self?.tasks = newTasks.filter { $0.state == .canceled || $0.state == .failed || $0.state == .success }
            self?.tableView.reloadData()
        }
    }
}

// MARK:- TableView Delegate & DataSource extension
extension CompletedTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as CompletedTaskTableViewCell
        cell.fill(task: tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
}
