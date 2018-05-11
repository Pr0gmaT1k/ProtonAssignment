//
//  Task+Utils.swift
//  ProtonAssignment
//
//  Created by azerty on 11/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit

extension Task {
    var startDateString: String? {
        return self.dateStart?.format(with: .asctime)
    }
    
    var endDateString: String? {
        return self.dateEnd?.format(with: .asctime)
    }
    
    var timeElapsedString: String? {
        guard let timelapse = self.time.value else { return nil }
        let s: Int = Int(timelapse) % 60
        let m: Int = Int(timelapse) / 60
        return String(format: "%0d:%02d", m, s)
    }
}
