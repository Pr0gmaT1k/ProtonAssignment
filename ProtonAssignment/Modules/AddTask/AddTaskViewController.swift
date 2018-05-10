//
//  AddTaskViewController.swift
//  ProtonAssignment
//
//  Created by azerty on 09/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable
import SkyFloatingLabelTextField

final class AddTaskViewController: UIViewController, StoryboardBased {
    // MARK:- IBOutlets
    @IBOutlet private weak var nameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet private weak var descTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet private weak var fileTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet private weak var addKeywordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:- Properties
    fileprivate var keywords = [String]()
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        // Text Field setup
        self.nameTextField.placeholder = L10n.addTaskNamePlaceholder
        self.descTextField.placeholder = L10n.addTaskDescPlaceholder
        self.fileTextField.placeholder = L10n.addTaksFilePlaceholder
        self.addKeywordTextField.placeholder = L10n.addTaksAddKeyWordPlaceholder
        self.nameTextField.delegate = self
        self.descTextField.delegate = self
        self.fileTextField.delegate = self
        self.addKeywordTextField.delegate = self
        
        // TableView setup
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(cellType: AddTaskTableViewCell.self)
    }
    
    // MARK:- IBActions
    @IBAction func addKeywordDidTouch(_ sender: Any) {
        guard let keyword = self.addKeywordTextField.text else { return /* TODO: Throw error */}
        keywords.insert(keyword, at: 0)
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.addKeywordTextField.text = nil
    }
    
    @IBAction func dismissDidTouch(_ sender: Any) {
        print("cancel")
        self.dismiss(animated: true)
    }
    
    @IBAction func chooseFileDidTouch(_ sender: Any) {
        print("open galery")
        self.view.endEditing(true)
    }
    
    @IBAction func saveDidTouch(_ sender: Any) {
        print("save")
        self.dismiss(animated: true)
    }
}

// MARK:- TextField Delegate
extension AddTaskViewController: UITextFieldDelegate {
    // Dimsiss keyboard when return is used
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

// MARK:- TableView Delegate & Datasource
extension AddTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as AddTaskTableViewCell
        cell.delegate = self
        cell.fill(keyword: keywords[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywords.count
    }
}

// MARK:- AddTaskTableViewCellDelegate
extension AddTaskViewController: AddTaskTableViewCellDelegate {
    func removeCell(addTaskTableViewCell: AddTaskTableViewCell, keyword: String) {
        guard let indexPath = self.tableView.indexPath(for: addTaskTableViewCell),
        let index = keywords.index(of: keyword) else { return /* TODO: Throw error */ }
        keywords.remove(at: index)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
