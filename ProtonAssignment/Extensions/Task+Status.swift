//
//  Task+Status.swift
//  ProtonAssignment
//
//  Created by azerty on 10/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit

enum TaskState {
    case pending
    case inProgress
    case delayed
    case canceled
    case failed
    case success
    case unknown
}

extension Task {
    var state: TaskState {
        switch self.status.value {
        case 1: return .pending
        case 2: return .delayed
        case 3: return .inProgress
        case 4: return .canceled
        case 5: return .failed
        case 6: return .success
        default: return .unknown
        }
    }
}
