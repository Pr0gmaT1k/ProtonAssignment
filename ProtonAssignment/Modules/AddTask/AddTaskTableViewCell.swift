//
//  AddTaskTableViewCell.swift
//  ProtonAssignment
//
//  Created by azerty on 10/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable
import SkyFloatingLabelTextField

protocol AddTaskTableViewCellDelegate: class {
    func removeCell(addTaskTableViewCell: AddTaskTableViewCell, keyword: String)
}

final class AddTaskTableViewCell: UITableViewCell, NibReusable {
    // MARK:- IBOutlets
    @IBOutlet private weak var keywordTextField: SkyFloatingLabelTextField!
    
    // MARK:- Properties
    weak var delegate: AddTaskTableViewCellDelegate?
    
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK:- IBActions
    @IBAction func removeDidTouch(_ sender: Any) {
        guard let keyword = keywordTextField.text else { return /* TODO: Throw error */ }
        delegate?.removeCell(addTaskTableViewCell: self, keyword: keyword)
    }
    
    // MARK:- Public func
    func fill(keyword: String) {
        self.keywordTextField.text = keyword
    }
}
