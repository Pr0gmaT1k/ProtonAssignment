//
//  InProgressTaskTableViewCell.swift
//  ProtonAssignment
//
//  Created by azerty on 09/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift

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
    @IBOutlet fileprivate weak var progress: UIProgressView!
    
    // MARK:- Properties
    fileprivate var notificationToken: NotificationToken?
    fileprivate let realm = Realm.safeInstance()
    weak var delegate: InProgressTaskTableViewCellDelegate?
    private var task: Task?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.progress.progress = 0
    }
    
    // Public func
    func fill(task: Task) {
        self.titleLabel.text = task.name
        self.descLabel.text = task.desc
        self.delayedImage.isHidden = task.state != .delayed 
        self.task = task
        self.notificationToken = task.observe {[weak self] (changes: ObjectChange) in
            self?.progress.progress = self?.task?.progress.value ?? 0
        }
    }
    
    // MARK:- IBActions
    @IBAction func cancelTaskDidTouch(_ sender: Any) {
        delegate?.taskDidCancel(inProgressTaskTVC: self, task: task)
        print("Task Did Cancel")
    }
}
