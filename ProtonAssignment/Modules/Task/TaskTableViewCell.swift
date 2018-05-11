//
//  TaskTableViewCell.swift
//  ProtonAssignment
//
//  Created by azerty on 07/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable

/** Delagate to communicate to controller selection & start event */
protocol TaskTableViewcellDelegate: class {
    func didSelect(taskTableViewCell: TaskTableViewCell)
    func didStartTask(taskTableViewCell: TaskTableViewCell, task: Task?, delayed: Bool)
    func remove(taskTableViewCell: TaskTableViewCell, task: Task?)
    func edit(taskTableViewCell: TaskTableViewCell, task: Task?)
}

/** The cell used in TaskViewController */
final class TaskTableViewCell: UITableViewCell, NibReusable {
    // MARK:- IBOutlets
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var leftViewWidth: NSLayoutConstraint!
    @IBOutlet private weak var rightViewWidth: NSLayoutConstraint!
    @IBOutlet private weak var delayLabel: UILabel!
    @IBOutlet private weak var startNowLablel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var editLabel: UILabel!
    @IBOutlet private weak var removeLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    
    // MARK:- Public Properties
    weak var delagate: TaskTableViewcellDelegate?
    var isTaskSelected: Bool = false {
        didSet {
            rightViewWidth.constant = isTaskSelected ? 120 : 0
            leftViewWidth.constant = isTaskSelected ? 120 : 0
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
                self.shadowView.alpha = self.isTaskSelected ? 0.3 : 0
            }
        }
    }
    
    // MARK:- Private properties
    private var task: Task?
    
    // MARK :- init
    override func awakeFromNib() {
        super.awakeFromNib()
        startNowLablel.text = L10n.taskVCStartNow
        delayLabel.text = L10n.taskVCStartDelayed
        editLabel.text = L10n.taskVCStartEdit
        removeLabel.text = L10n.taskVCStartRemove
    }
    
    // MARK:- Public func
    func fill(task: Task) {
        self.titleLabel.text = task.name
        self.descLabel.text = task.desc
        self.task = task
    }
    
    // MARK:- IBAction
    @IBAction func didSelectCell(_ sender: Any) {
        delagate?.didSelect(taskTableViewCell: self)
        isTaskSelected = !isTaskSelected
    }
    
    @IBAction func startNowDidTouch(_ sender: Any) {
        delagate?.didStartTask(taskTableViewCell: self, task: task, delayed: false)
        isTaskSelected = false
    }
    
    @IBAction func delayedOneMinute(_ sender: Any) {
        delagate?.didStartTask(taskTableViewCell: self, task: task, delayed: true)
        isTaskSelected = false
    }
    
    @IBAction func editDidTouch(_ sender: Any) {
        delagate?.edit(taskTableViewCell: self, task: task)
        isTaskSelected = false
    }
    
    @IBAction func removeDidTouch(_ sender: Any) {
        delagate?.remove(taskTableViewCell: self, task: task)
        isTaskSelected = false
    }
    
}
