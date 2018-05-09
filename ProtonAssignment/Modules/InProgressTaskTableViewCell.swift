//
//  InProgressTaskTableViewCell.swift
//  ProtonAssignment
//
//  Created by azerty on 09/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable

protocol InProgressTaskTableViewCellDelegate: class {
    func taskDidCancel(inProgressTaskTVC: InProgressTaskTableViewCell)
}

final class InProgressTaskTableViewCell: UITableViewCell, NibReusable {
    // MARK:- IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tptLabel: UILabel!
    
    // MARK:- Properties
    weak var delegate: InProgressTaskTableViewCellDelegate?
    
    // MARK:- IBActions
    @IBAction func cancelTaskDidTouch(_ sender: Any) {
        delegate?.taskDidCancel(inProgressTaskTVC: self)
    }
}
