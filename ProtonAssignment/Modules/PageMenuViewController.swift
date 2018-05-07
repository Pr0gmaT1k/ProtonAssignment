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
        // Page Menu
        // Setup VC
        let taskVC = StoryboardScene.Main.taskViewController.instantiate()
        taskVC.title = L10n.pageMenuTask
        
        let completedTaskVC = StoryboardScene.Main.completedTaskViewController.instantiate()
        completedTaskVC.title = L10n.pageMenuCompleted
        
        controllerArray.append(contentsOf: [taskVC, completedTaskVC])
        
        // Page menu options
        let parameters: [CAPSPageMenuOption] = [
            .centerMenuItems(true),
            .scrollMenuBackgroundColor(UIColor(named: .secondary)),
            .viewBackgroundColor(UIColor.groupTableViewBackground),
            .unselectedMenuItemLabelColor(.white),
            .selectionIndicatorHeight(1)
        ]
        
        // Init and add menu
        let frame = self.pageContainer.bounds
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height), pageMenuOptions: parameters)
        guard let pageMenu = pageMenu else { return }
        self.pageContainer.addSubview(pageMenu.view)
    }
}
