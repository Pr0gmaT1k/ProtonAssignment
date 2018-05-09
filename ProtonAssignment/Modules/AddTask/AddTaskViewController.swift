//
//  AddTaskViewController.swift
//  ProtonAssignment
//
//  Created by azerty on 09/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import Reusable

final class AddTaskViewController: UIViewController, StoryboardBased {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dismissDidTouch(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
