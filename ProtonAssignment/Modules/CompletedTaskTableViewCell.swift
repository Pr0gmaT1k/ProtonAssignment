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
    @IBOutlet private weak var descLabel: UIView!
    @IBOutlet private weak var sucessLabel: UILabel!
    @IBOutlet private weak var startDateLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    // MARK:- func
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
