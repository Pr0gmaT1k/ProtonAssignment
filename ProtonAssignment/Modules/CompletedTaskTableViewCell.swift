//
//  CompletedTaskTableViewCell.swift
//  ProtonAssignment
//
//  Created by azerty on 09/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable

/** Cell who display information of task execution history */
final class CompletedTaskTableViewCell: UITableViewCell, NibReusable {
    // MARK:- IBoutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var sucessLabel: UILabel!
    @IBOutlet private weak var startDateLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    // MARK:- func
    func fill(task: Task) {
        self.titleLabel.text = task.name
        self.descLabel.text = task.desc
        switch task.state {
        case .canceled:
            sucessLabel.text = L10n.taskStateCancelled
            sucessLabel.textColor = .red
            sucessLabel.layer.borderColor = UIColor.red.cgColor
        case .failed:
            sucessLabel.text = L10n.taskStateFailed
            sucessLabel.textColor = .red
            sucessLabel.layer.borderColor = UIColor.red.cgColor
        case .success:
            sucessLabel.text = L10n.taskStateCompleted
            sucessLabel.textColor = .green
            sucessLabel.layer.borderColor = UIColor.green.cgColor
        default:
            sucessLabel.text = nil
            sucessLabel.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
