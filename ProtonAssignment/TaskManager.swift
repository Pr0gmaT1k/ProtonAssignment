//
//  TaskManager.swift
//  ProtonAssignment
//
//  Created by azerty on 11/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import UIKit
import FilesProvider
import RealmSwift

final class TaskManager {
    // MARK:- Singelton
    static let shared = TaskManager()
    
    // MARK:- Properties
    fileprivate let realm = Realm.safeInstance()
    private var notificationToken: NotificationToken?
    fileprivate let creds = URLCredential.init(user: "Pr0gmaT1k", password: "test1234", persistence: URLCredential.Persistence.forSession)
    fileprivate var urlYandex = URL(string: "https://webdav.yandex.com")
    fileprivate var webDAV: WebDAVFileProvider?
    fileprivate var currentTask = [Task: Progress?]()
    
    // MARK:- Init
    private init() {
        guard let url = urlYandex else { return }
        webDAV = WebDAVFileProvider(baseURL: url, credential: creds)
        webDAV?.delegate = self
    }
    
    // MARK:- publlic func
    func lauchTask(task: Task, delayed: Bool) {let url = URL(fileURLWithPath: task.fileUrl)
        try? realm.write {
            task.status.value = delayed ? 2 : 3
            task.dateStart = Date()
        }
        if delayed { // Delayed 1 minute
            DispatchQueue.main.asyncAfter(deadline: .now() + 60) { [weak self] in
                // break if task change his state
                if task.state != .delayed { return }
                try? self?.realm.write { task.status.value = 3 }
                let progress = self?.webDAV?.copyItem(localFile: url, to: url.lastPathComponent, overwrite: true, completionHandler: nil)
                self?.currentTask[task] = progress
            }
        } else {
            let progress = webDAV?.copyItem(localFile: url, to: url.lastPathComponent, overwrite: true, completionHandler: nil)
            currentTask[task] = progress
        }
    }
    
    func cancelTask(task: Task) {
        currentTask[task]??.cancel()
        try? realm.write {
            task.status.value = 4
            task.dateEnd = Date()
        }
    }
    
    func cancelAll() {
        for progress in self.currentTask {
            self.cancelTask(task: progress.key)
        }
    }
    
    // MARK:- Private func
    fileprivate func changeTaskState(from operation: FileOperationType, state: Int16) {
        // TODO: found an elegant solution...
        let primaryKey = operation.source.replacingOccurrences(of: "file://", with: "")
        guard let task = realm.object(ofType: Task.self, forPrimaryKey: primaryKey) else { return } /* TODO: error */
        // Change the state only if the status is .pending
        if task.state == .inProgress {
            try? realm.write {
                task.status.value = state
                task.dateEnd = Date()
                guard let startDate = task.dateStart else { return }
                task.time.value = task.dateEnd?.timeIntervalSince(startDate)
            }
        }
    }
    
    fileprivate func updateProgress(operation: FileOperationType, progress: Float) {
        let primaryKey = operation.source.replacingOccurrences(of: "file://", with: "")
        guard let task = realm.object(ofType: Task.self, forPrimaryKey: primaryKey) else { return } /* TODO: error */
        try? realm.write { task.progress.value = progress }
    }
}

// MARK: - FileProviderDelegate
extension TaskManager: FileProviderDelegate {
    func fileproviderFailed(_ fileProvider: FileProviderOperations, operation: FileOperationType, error: Error) {
        changeTaskState(from: operation, state: 5)
        print("failed")
    }
    
    func fileproviderSucceed(_ fileProvider: FileProviderOperations, operation: FileOperationType) {
        print("succeed")
        changeTaskState(from: operation, state: 6)
    }
    
    func fileproviderProgress(_ fileProvider: FileProviderOperations, operation: FileOperationType, progress: Float) {
        print("Copy \(progress * 100) completed.")
        self.updateProgress(operation: operation, progress: progress)
    }
}
