// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {
  /// COMPLETED
  static let pageMenuCompleted = L10n.tr("Localizable", "page_menu_completed")
  /// IN PROGRESS
  static let pageMenuInProgress = L10n.tr("Localizable", "page_menu_in_progress")
  /// TASK
  static let pageMenuTask = L10n.tr("Localizable", "page_menu_task")
  /// DELAYED ONE MINUTE
  static let taskVCStartDelayed = L10n.tr("Localizable", "taskVC_start_delayed")
  /// START NOW
  static let taskVCStartNow = L10n.tr("Localizable", "taskVC_start_now")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
