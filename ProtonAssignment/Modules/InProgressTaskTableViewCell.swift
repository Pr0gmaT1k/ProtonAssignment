//
//  InProgressTaskTableViewCell.swift
//  ProtonAssignment
//
//  Created by azerty on 09/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable

/** Delegate to communicate with controller cancel task event */
protocol InProgressTaskTableViewCellDelegate: class {
    func taskDidCancel(inProgressTaskTVC: InProgressTaskTableViewCell, task: Task?)
}

/** Cell used in InProgressTaskViewController to display task in progress */
final class InProgressTaskTableViewCell: UITableViewCell, NibReusable {
    // MARK:- IBOutlets
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var descLabel: UILabel!
    @IBOutlet fileprivate weak var tptLabel: UILabel!
    @IBOutlet fileprivate weak var delayedImage: UIImageView!
    
    // MARK:- Properties
    weak var delegate: InProgressTaskTableViewCellDelegate?
    private var task: Task?
    
    // Public func
    func fill(task: Task) {
        self.titleLabel.text = task.name
        self.descLabel.text = task.desc
        self.delayedImage.isHidden = task.state != .delayed 
        self.task = task
    }
    
    // MARK:- IBActions
    @IBAction func cancelTaskDidTouch(_ sender: Any) {
        delegate?.taskDidCancel(inProgressTaskTVC: self, task: task)
        print("Task Did Cancel")
    }
}
