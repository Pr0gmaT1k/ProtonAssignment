//
//  PageMenuViewController.swift
//  ProtonAssignment
//
//  Created by azerty on 07/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import PageMenu

final class PageMenuViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet private weak var pageContainer: UIView!
    
    // MARK:- Properties
    private var pageMenu: CAPSPageMenu?
    private var controllerArray: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddTaskVC))
        self.navigationController?.navigationBar.tintColor = .white
        
        // Page Menu
        // Setup VC
        let taskVC = StoryboardScene.Main.taskViewController.instantiate()
        taskVC.title = L10n.pageMenuTask
        taskVC.delegate = self
        
        let inProgressTaskVC = StoryboardScene.Main.inProgressTaskViewController.instantiate()
        inProgressTaskVC.title = L10n.pageMenuInProgress
        
        let completedTaskVC = StoryboardScene.Main.completedTaskViewController.instantiate()
        completedTaskVC.title = L10n.pageMenuCompleted
        
        controllerArray.append(contentsOf: [taskVC, inProgressTaskVC, completedTaskVC])
        
        // Page menu options
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor(named: .secondary)),
            .viewBackgroundColor(UIColor.groupTableViewBackground),
            .unselectedMenuItemLabelColor(.white),
            .selectionIndicatorHeight(1),
            .useMenuLikeSegmentedControl(true)
        ]
        
        // Init and add menu
        let frame = self.pageContainer.bounds
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height), pageMenuOptions: parameters)
        guard let pageMenu = pageMenu else { return }
        self.pageContainer.addSubview(pageMenu.view)
    }
    
    @objc func presentAddTaskVC() {
        let vc = StoryboardScene.Main.addTaskViewController.instantiate()
        self.navigationController?.present(vc, animated: true)
    }
}

extension PageMenuViewController: TaskViewControllerDelegate {
    func edit(taskViewController: TaskViewController, task: Task) {
        let vc = StoryboardScene.Main.addTaskViewController.instantiate()
        self.present(vc, animated: true) {
            vc.fill(task: task)
        }
    }
}
