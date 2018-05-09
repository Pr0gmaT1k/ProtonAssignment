//
//  InProgressTaskViewController.swift
//  ProtonAssignment
//
//  Created by azerty on 09/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable

final class InProgressTaskViewController: UIViewController, StoryboardBased {
    // MARK:- IBOutlet
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK:- Properties
    fileprivate var task = ["foo", "toto", "blabla"]
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View setup
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(cellType: InProgressTaskTableViewCell.self)
    }
}

// MARK:- TableView Delegate & DataSource extension
extension InProgressTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as InProgressTaskTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
}

// MARK:- InProgressTaskTableViewCellDelegate
extension InProgressTaskViewController: InProgressTaskTableViewCellDelegate {
    func taskDidCancel(inProgressTaskTVC: InProgressTaskTableViewCell) {
        // TODO...
    }
}
