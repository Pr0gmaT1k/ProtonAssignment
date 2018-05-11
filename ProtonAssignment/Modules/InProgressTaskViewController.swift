//
//  InProgressTaskViewController.swift
//  ProtonAssignment
//
//  Created by azerty on 09/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift
import FileProvider

/** Display and cancel task in progress  */
final class InProgressTaskViewController: UIViewController, StoryboardBased {
    // MARK:- IBOutlet
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var emptyLabel: UILabel!
    
    // MARK:- Properties
    fileprivate var tasks = [Task]() {
        didSet { self.tableView.isHidden = tasks.isEmpty }
    }
    fileprivate var notificationToken: NotificationToken?
    fileprivate let realm = Realm.safeInstance()
//    fileprivate let fileProvider = FileManager.
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View setup
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(cellType: InProgressTaskTableViewCell.self)
        
        // Empty label
        self.emptyLabel.text = L10n.inprogressTaskEmpty
        
        // Realm
        let tasksResults = realm.objects(Task.self)
        self.tasks = tasksResults.filter { $0.state == .inProgress || $0.state == .delayed }
        notificationToken = tasksResults.observe {[weak self] (changes: RealmCollectionChange) in
            guard let newTasks = self?.realm.objects(Task.self) else { return }
            self?.tasks = newTasks.filter { $0.state == .inProgress || $0.state == .delayed }
            self?.tableView.reloadData()
        }
    }
}

// MARK:- TableView Delegate & DataSource extension
extension InProgressTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as InProgressTaskTableViewCell
        cell.delegate = self
        cell.fill(task: tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
}

// MARK:- InProgressTaskTableViewCellDelegate
extension InProgressTaskViewController: InProgressTaskTableViewCellDelegate {
    func taskDidCancel(inProgressTaskTVC: InProgressTaskTableViewCell, task: Task?) {
        guard let task = task else { return /*TODO: Throw error*/ }
        try? realm.write { task.status.value = 4 }
    }
}
