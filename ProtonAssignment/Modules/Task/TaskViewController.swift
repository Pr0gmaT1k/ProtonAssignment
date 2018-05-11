//
//  TaskViewController.swift
//  ProtonAssignment
//
//  Created by azerty on 07/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift

protocol TaskViewControllerDelegate: class {
    func edit(taskViewController: TaskViewController, task: Task)
}

/** ViewController that display ready to launch task */
final class TaskViewController: UIViewController, StoryboardBased {
    // MARK:- IBOutlet
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var emptyLabel: UILabel!
    
    // MARK:- Properties
    fileprivate var tasks = [Task]() {
        didSet { self.tableView.isHidden = tasks.isEmpty }
    }
    fileprivate var notificationToken: NotificationToken?
    fileprivate let realm = Realm.safeInstance()
    weak var delegate: TaskViewControllerDelegate?
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View setup
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(cellType: TaskTableViewCell.self)
        
        // Emtpy Label
        self.emptyLabel.text = L10n.pendingTaskEmpty
        
        // Realm
        let tasksResults = realm.objects(Task.self)
        self.tasks = tasksResults.filter { $0.state == .pending }
        notificationToken = tasksResults.observe {[weak self] (changes: RealmCollectionChange) in
            guard let newTasks = self?.realm.objects(Task.self) else { return }
            self?.tasks = newTasks.filter { $0.state == .pending }
            self?.tableView.reloadData()
        }
    }
}

// MARK:- TableView Delegate & DataSource extension
extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as TaskTableViewCell
        cell.delagate = self
        cell.fill(task: tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
}

// MARK:- TaskTableViewcellDelegate
extension TaskViewController: TaskTableViewcellDelegate {
    func didSelect(taskTableViewCell: TaskTableViewCell) {
        // If the select task is already selected, there is nothing to do
        if taskTableViewCell.isTaskSelected { return }
        // else found the visible selected task
        let visibleCells = self.tableView.visibleCells.compactMap { $0 as? TaskTableViewCell }
        for visibleCell in visibleCells where visibleCell.isTaskSelected {
            visibleCell.isTaskSelected = false
        }
    }
    
    func didStartTask(taskTableViewCell: TaskTableViewCell, task: Task?, delayed: Bool) {
        guard let task = task else { return /*TODO: Throw error*/ }
        _ = TaskManager.shared.lauchTask(task: task, delayed: delayed)
    }
    
    func edit(taskTableViewCell: TaskTableViewCell, task: Task?) {
        guard let task = task else { return /* TODO: throw error */ }
        delegate?.edit(taskViewController: self, task: task)
    }
    
    func remove(taskTableViewCell: TaskTableViewCell, task: Task?) {
        guard let task = task else { return /* TODO: Throw error */ }
        try? realm.write { realm.delete(task) }
    }
}
