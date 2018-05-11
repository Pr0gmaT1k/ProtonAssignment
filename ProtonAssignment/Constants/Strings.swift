// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {
  /// Add Keyword
  static let addTaksAddKeyWordPlaceholder = L10n.tr("Localizable", "add_taks_addKeyWord_placeholder")
  /// File *
  static let addTaksFilePlaceholder = L10n.tr("Localizable", "add_taks_file_placeholder")
  /// Description
  static let addTaskDescPlaceholder = L10n.tr("Localizable", "add_task_desc_placeholder")
  /// Name *
  static let addTaskNamePlaceholder = L10n.tr("Localizable", "add_task_name_placeholder")
  /// There is no completed task
  static let completedTaskEmpty = L10n.tr("Localizable", "completed_task_empty")
  /// There is no task in progress
  static let inprogressTaskEmpty = L10n.tr("Localizable", "inprogress_task_empty")
  /// COMPLETED
  static let pageMenuCompleted = L10n.tr("Localizable", "page_menu_completed")
  /// IN PROGRESS
  static let pageMenuInProgress = L10n.tr("Localizable", "page_menu_in_progress")
  /// TASK
  static let pageMenuTask = L10n.tr("Localizable", "page_menu_task")
  /// There is no pending task
  static let pendingTaskEmpty = L10n.tr("Localizable", "pending_task_empty")
  /// canceled
  static let taskStateCancelled = L10n.tr("Localizable", "task_state_cancelled")
  /// completed
  static let taskStateCompleted = L10n.tr("Localizable", "task_state_completed")
  /// failed
  static let taskStateFailed = L10n.tr("Localizable", "task_state_failed")
  /// DELAYED
  static let taskVCStartDelayed = L10n.tr("Localizable", "taskVC_start_delayed")
  /// EDIT
  static let taskVCStartEdit = L10n.tr("Localizable", "taskVC_start_edit")
  /// START
  static let taskVCStartNow = L10n.tr("Localizable", "taskVC_start_now")
  /// REMOVE
  static let taskVCStartRemove = L10n.tr("Localizable", "taskVC_start_remove")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
