//
//  TaskManagerTest.swift
//  ProtonAssignmentTests
//
//  Created by azerty on 11/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import XCTest
@testable import ProtonAssignment
import RealmSwift


class TaskManagerTest: XCTestCase {
    var taskManager: TaskManager?
    var realm = Realm.safeInstance()
    var testTask: Task {
        let task = Task()
        task.fileUrl = arc4random().description
        task.name = ""
        return task
    }
    
    override func setUp() {
        super.setUp()
        taskManager = TaskManager.shared
    }
    
    override func tearDown() {
        super.tearDown()
        try? realm.write { realm.deleteAll() }
    }
    
    func addGenericTaskInRealm() -> Task {
        let task = testTask
        try? realm.write { realm.add(task) }
        return task
    }
    
    func testlaunchTaskNow() {
        let task = self.addGenericTaskInRealm()
        taskManager?.lauchTask(task: task, delayed: false)
        XCTAssert(task.state == .inProgress)
    }
    
    func testLaunchTaskDelayed() {
        let task = self.addGenericTaskInRealm()
        taskManager?.lauchTask(task: task, delayed: true)
        XCTAssert(task.state == .delayed)
    }
    
    func testCancelTaskInProgress() {
        let task = self.addGenericTaskInRealm()
        taskManager?.lauchTask(task: task, delayed: false)
        taskManager?.cancelTask(task: task)
        XCTAssert(task.state == .canceled)
    }
    
    func testCancelTaskDelayed() {
        let task = self.addGenericTaskInRealm()
        taskManager?.lauchTask(task: task, delayed: true)
        taskManager?.cancelTask(task: task)
        XCTAssert(task.state == .canceled)
    }
    
    func testCancellAllTask() {
        for _ in 0...10 {
            let task = addGenericTaskInRealm()
            taskManager?.lauchTask(task: task, delayed: false)
        }
        taskManager?.cancelAll()
        let tasks = realm.objects(Task.self).filter { $0.state != .canceled }
        XCTAssert(tasks.isEmpty)
    }
}
