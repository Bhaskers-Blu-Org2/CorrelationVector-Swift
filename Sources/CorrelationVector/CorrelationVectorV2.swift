import Foundation

@objc internal class CorrelationVectorV2: CorrelationVectorBase, CorrelationVectorProtocol {

  internal static let maxVectorLength = 127
  internal static let baseLength = 22

  var value: String {
    // TODO
    return ""
  }

  var base: String {
    // TODO
    return ""
  }

  var version: CorrelationVectorVersion {
    return .v2
  }

  required convenience init() {
    // TODO
    self.init("", 0, false)
  }

  required convenience init(_ vectorBase: UUID) {
    // TODO
    self.init("", 0, false)
  }

  required init(_ baseVector: String, _ extension: Int, _ immutable: Bool) {
    super.init(baseVector, `extension`, immutable)
  }

  func increment() -> String {
    // TODO
    return ""
  }

  static func parse(_ correlationVector: String?) -> CorrelationVectorProtocol {
    return parse(from: correlationVector)
  }

  static func extend(_ correlationVector: String?) -> CorrelationVectorProtocol {
    return extend(from: correlationVector, maxVectorLength, baseLength)
  }

  static func spin(_ correlationVector: String?) -> CorrelationVectorProtocol {
    // TODO
    return CorrelationVector()
  }
}
