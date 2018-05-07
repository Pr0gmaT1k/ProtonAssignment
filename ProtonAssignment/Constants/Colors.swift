// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable operator_usage_whitespace
extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable identifier_name line_length type_body_length
struct ColorName {
  let rgbaValue: UInt32
  var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#525062"></span>
  /// Alpha: 100% <br/> (0x525062ff)
  static let appIconBackGround = ColorName(rgbaValue: 0x525062ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c1d6c3"></span>
  /// Alpha: 100% <br/> (0xc1d6c3ff)
  static let green = ColorName(rgbaValue: 0xc1d6c3ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#514f5f"></span>
  /// Alpha: 100% <br/> (0x514f5fff)
  static let primary = ColorName(rgbaValue: 0x514f5fff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9594cc"></span>
  /// Alpha: 100% <br/> (0x9594ccff)
  static let purple = ColorName(rgbaValue: 0x9594ccff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff0006"></span>
  /// Alpha: 100% <br/> (0xff0006ff)
  static let red = ColorName(rgbaValue: 0xff0006ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c7c6cb"></span>
  /// Alpha: 100% <br/> (0xc7c6cbff)
  static let secondary = ColorName(rgbaValue: 0xc7c6cbff)
}
// swiftlint:enable identifier_name line_length type_body_length

extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
