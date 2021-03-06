// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

import Foundation

/// This class represents a lightweight vector for identifying and measuring causality.
@objc(MSCVCorrelationVector)
public class CorrelationVector: NSObject, CorrelationVectorProtocol {
  internal static let delimiter: Character = "."
  internal static let terminator = "!"

  /// This is the header that should be used between services to pass the
  /// correlation vector.
  public static let headerName = "MS-CV";

  /// Gets or sets a value indicating whether or not to validate the correlation
  /// vector on creation.
  public static var validateDuringCreation = false

  private var implementation: CorrelationVectorProtocol

  /// The value of the correlation vector as a string.
  public var value: String {
    return self.implementation.value
  }

  /// The base value of the correlation vector.
  public var base: String {
    return self.implementation.base
  }

  /// The extension number.
  public var `extension`: UInt32 {
    return self.implementation.extension
  }

  /// The version of the correlation vector implementation.
  public var version: CorrelationVectorVersion {
    return self.implementation.version
  }

  /// A string representation of the CV.
  public override var description: String {
    return self.value
  }

  /// Initializes a new instance of the Correlation Vector with V1 implementation.
  /// This should only be called when no correlation vector was found in the
  /// message header.
  public required override convenience init() {
    self.init(.v1)
  }

  /// Initializes a new instance of the Correlation Vector of the V2 implementation
  /// using the given UUID as the vector base.
  ///
  /// - Parameter base: the UUID to use as a correlation vector base.
  public required convenience init(_ base: UUID) {
    self.init(CorrelationVectorV2(base))
  }

  /// Initializes a new instance of the Correlation Vector of the given
  /// implementation version. This should only be called when no correlation vector
  /// was found in the message header.
  ///
  /// - Parameter version: the Correlation Vector implementation version.
  @objc(initWithVersion:)
  public convenience init(_ version: CorrelationVectorVersion) {
    self.init(version.type.init())
  }

  /// Initializes a new instance of the Correlation Vector of the given
  /// implementation version and UUID as the vector base.
  ///
  /// - Parameters:
  ///   - version: the Correlation Vector implementation version.
  ///   - base: the UUID to use as a correlation vector base.
  public required convenience init(_ version: CorrelationVectorVersion, _ base: UUID) {
    self.init(version.type.init(base))
  }

  private init(_ implementation: CorrelationVectorProtocol) {
    self.implementation = implementation
    super.init()
  }

  /// Increments the extension, the numerical value at the end of the vector, by one
  /// and returns the string representation.
  ///
  /// - Returns: the new cV value as a string that you can add to the outbound message header.
  public func increment() -> String {
    return self.implementation.increment()
  }

  /// Determines whether two instances of the CorrelationVector class are equal.
  ///
  /// - Parameters:
  ///   - lhs: a value to compare.
  ///   - rhs: another value to compare.
  /// - Returns: a boolean value indicating whether two values are equal.
  static func ==(lhs: CorrelationVector, rhs: CorrelationVector) -> Bool {
    return lhs.value == rhs.value
  }

  /// Converts a string representation of a Correlation Vector into this class.
  ///
  /// - Parameter correlationVector: string representation.
  /// - Returns: the Correlation Vector based on its version.
  public static func parse(_ correlationVector: String?) -> CorrelationVectorProtocol {
    let version = inferVersion(correlationVector)
    let instance = version.type.parse(correlationVector)
    return CorrelationVector(instance)
  }

  /// Creates a new correlation vector by extending an existing value.
  /// This should be done at the entry point of an operation.
  ///
  /// - Parameter correlationVector: string representation.
  /// - Returns: the Correlation Vector based on its version.
  /// - Throws: CorrelationVectorError.invalidArgument if vector is not valid.
  public static func extend(_ correlationVector: String?) throws -> CorrelationVectorProtocol {
    let version = inferVersion(correlationVector)
    let instance = try version.type.extend(correlationVector)
    return CorrelationVector(instance)
  }

  /// Creates a new correlation vector by applying the spin operator to an existing value.
  /// This should be done at the entry point of an operation.
  ///
  /// - Parameters:
  ///   - correlationVector: string representation.
  ///   - parameters: the parameters to use when applying the Spin operator.
  /// - Returns: the Correlation Vector based on its version.
  /// - Throws: CorrelationVectorError.invalidOperation if spin operation isn't supported
  ///           for this correlation vector.
  public static func spin(_ correlationVector: String?, _ parameters: SpinParameters) throws -> CorrelationVectorProtocol {
    let version = inferVersion(correlationVector)
    let instance = try version.type.spin(correlationVector, parameters)
    return CorrelationVector(instance)
  }

  /// Identifies which version of the Correlation Vector is being used.
  ///
  /// - Parameter correlationVector: string representation.
  /// - Returns: An enum indicating correlation vector version.
  private static func inferVersion(_ correlationVector: String?) -> CorrelationVectorVersion {
    if let index = correlationVector?.firstIndex(of: delimiter) {
      let distance = correlationVector!.distance(from: correlationVector!.startIndex, to: index)
      if CorrelationVectorV1.baseLength == distance {
        return .v1
      } else if CorrelationVectorV2.baseLength == distance {
        return .v2
      }
    }
    // Use version 1 by default.
    return .v1
  }
}
