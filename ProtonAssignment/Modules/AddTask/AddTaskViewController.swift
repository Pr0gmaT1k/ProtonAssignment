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
import Photos
import RealmSwift

final class AddTaskViewController: UIViewController, StoryboardBased {
    // MARK:- IBOutlets
    @IBOutlet fileprivate weak var nameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet fileprivate weak var descTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet fileprivate weak var fileTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet fileprivate weak var addKeywordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK:- Properties
    fileprivate var keywords = [String]()
    fileprivate var imagePicker = UIImagePickerController()
    fileprivate let realm = Realm.safeInstance()
    fileprivate var fileURL: NSURL?
    fileprivate var editTask: Task?
    
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
        
        // ImagePickerControler setup
        PHPhotoLibrary.requestAuthorization { auth in print(auth) }
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .popover
        imagePicker.delegate = self
    }
    
    func fill(task: Task) {
        self.editTask = task
        self.nameTextField.text = task.name
        self.descTextField.text = task.desc
        self.keywords = task.keywords.flatMap { $0.keyword }
        guard let url = NSURL.init(string: task.fileUrl) else { return }
        self.fileURL = url
        self.fileTextField.text = url.lastPathComponent
        self.tableView.reloadData()
    }
    
    // MARK:- IBActions
    @IBAction func addKeywordDidTouch(_ sender: Any) {
        if self.addKeywordTextField.text?.isEmpty == true { return }
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
        self.present(imagePicker, animated: true)
        self.view.endEditing(true)
    }
    
    @IBAction func saveDidTouch(_ sender: Any) {
        if nameTextField.text?.isEmpty == true {
            nameTextField.placeholderColor = .red
            return
        }
        
        if fileTextField.text?.isEmpty == true {
            fileTextField.placeholderColor = .red
            return
        }
        
        guard let name = nameTextField.text,
            let fileURL = fileURL?.path else { return /* TODO: Throw error */ }
        
        // Write
        if let task = self.editTask {
            // Edit
            try? realm.write {task.name = name
                task.desc = descTextField.text
                task.keywords.removeAll()
                for keyword in self.keywords {
                    task.keywords.append(Keywords(keyword: keyword))
                }
                realm.add(task, update: true)
                self.dismiss(animated: true)
            }
        } else {
            // Create
            let task = Task()
            task.name = name
            task.desc = descTextField.text
            for keyword in self.keywords {
                task.keywords.append(Keywords(keyword: keyword))
            }
            task.fileUrl = fileURL
            task.status.value = 1
            try? realm.write {
                realm.add(task)
                self.dismiss(animated: true)
            }
        }
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

// MARK:- UIImagePickerControllerDelegate
extension AddTaskViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        self.fileTextField.text = (info[UIImagePickerControllerImageURL] as? NSURL)?.lastPathComponent
        self.fileURL = info[UIImagePickerControllerImageURL] as? NSURL
        self.imagePicker.dismiss(animated: true)
    }
}
