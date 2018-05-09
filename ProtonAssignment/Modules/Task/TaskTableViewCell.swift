//
//  TaskTableViewCell.swift
//  ProtonAssignment
//
//  Created by azerty on 07/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable

protocol TaskTableViewcellDelegate: class {
    func didSelect(taskTableViewCell: TaskTableViewCell)
    func didStartTask(taskTableViewCell: TaskTableViewCell, delayed: Bool)
}

/** The cell used in TaskViewController */
final class TaskTableViewCell: UITableViewCell, NibReusable {
    // MARK:- IBOutlets
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var leftViewWidth: NSLayoutConstraint!
    @IBOutlet private weak var rightViewWidth: NSLayoutConstraint!
    @IBOutlet private weak var rightLabel: UILabel!
    @IBOutlet private weak var leftLabel: UILabel!
    
    // MARK:- Public Properties
    weak var delagate: TaskTableViewcellDelegate?
    var isTaskSelected: Bool = false {
        didSet {
            rightViewWidth.constant = isTaskSelected ? 80 : 0
            leftViewWidth.constant = isTaskSelected ? 80 : 0
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
                self.shadowView.alpha = self.isTaskSelected ? 0.3 : 0
            }
        }
    }
    
    // MARK :- init
    override func awakeFromNib() {
        super.awakeFromNib()
        leftLabel.text = L10n.taskVCStartNow
        rightLabel.text = L10n.taskVCStartDelayed
    }
    
    // MARK:- IBAction
    @IBAction func didSelectCell(_ sender: Any) {
        delagate?.didSelect(taskTableViewCell: self)
        isTaskSelected = !isTaskSelected
    }
    
    @IBAction func startNowDidTouch(_ sender: Any) {
        print("start now")
        delagate?.didStartTask(taskTableViewCell: self, delayed: false)
        isTaskSelected = false
    }
    
    @IBAction func delayedOneMinute(_ sender: Any) {
        print("delay one minute")
        delagate?.didStartTask(taskTableViewCell: self, delayed: true)
        isTaskSelected = false
    }
}
