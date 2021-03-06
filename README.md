[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

# Legal Notices

Microsoft and any contributors grant you a license to the Microsoft documentation and other content
in this repository under the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/legalcode),
see the [LICENSE](LICENSE) file, and grant you a license to any code in the repository under the [MIT License](https://opensource.org/licenses/MIT), see the
[LICENSE-CODE](LICENSE-CODE) file.

Microsoft, Windows, Microsoft Azure and/or other Microsoft products and services referenced in the documentation
may be either trademarks or registered trademarks of Microsoft in the United States and/or other countries.
The licenses for this project do not grant you rights to use any Microsoft names, logos, or trademarks.
Microsoft's general trademark guidelines can be found at http://go.microsoft.com/fwlink/?LinkID=254653.

Privacy information can be found at https://privacy.microsoft.com/en-us/

Microsoft and any contributors reserve all other rights, whether under their respective copyrights, patents,
or trademarks, whether by implication, estoppel or otherwise.

# Installation

## Swift Package Manager

1. Run `swift package init` if it hasn't been initialized
2. Add the following dependency to the **Package** section in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/microsoft/CorrelationVector-Swift.git", from: "1.0.0")
]
```

3. Add dependency to the **Package** > **targets** > **target** > **dependencies** section

```swift
.target(
    name: "YourApp",
    dependencies: ["CorrelationVector"])
```

4. Run `swift build` to download, link and compile dependencies

## CocoaPods

1. Run `pod init` if it hasn't been initialized
2. Add the following line to the corresponding target section in the **Podfile**:

```
pod 'CorrelationVector'
```

3. Run `pod install`

Learn more about using CocoaPods in [the official guide](https://guides.cocoapods.org/using/using-cocoapods.html).

## Carthage

1. Run `touch Cartfile` if `Cartfile` hasn't been created
2. Add the following line in `Cartfile`:

```
github "microsoft/CorrelationVector-Swift"
```

3. Run `carthage update --platform iOS` and follow the [additional steps](https://github.com/Carthage/Carthage#getting-started) in order to add the framework to your project.

# Usage

For general info on correlation vector, refer to [specification](https://github.com/microsoft/CorrelationVector/blob/master/cV%20-%202.1.md).

## Initialize new vector

```swift
// Implicit creation
let correlationVector = CorrelationVector()

// Explicit creation
let correlationVectorV1 = CorrelationVector(.v1)
let correlationVectorV2 = CorrelationVector(.v2)

// Automatic version detection
let parsedCorrelationVector = CorrelationVector.parse("vtul4NUsfs9Cl7mOf.1")
```

## Create new vector by extending an existing value

```swift
// Initialize "vtul4NUsfs9Cl7mOf.1.0" correlation vector by extending an existing value
do {
    let correlationVector = try CorrelationVector.extend("vtul4NUsfs9Cl7mOf.1")
} catch CorrelationVectorError.invalidArgument(let description) {
    // log the error
} catch CorrelationVectorError.invalidOperation(let description) {
    // log the error
} catch {
    // log the error
}
```

## Spin

**NOTE:** Spin operator can only be used on v2 correlation vectors

```swift
let correlationVector = CorrelationVector(.v2)
let params = SpinParameters(interval: .fine, periodicity: .short, entropy: .two)
do {
    let spinCorrelationVector = try CorrelationVector.spin(correlationVector.value, params)
} catch {
    // log the error
}
```

## General methods

```swift
do {
    // Initialize "vtul4NUsfs9Cl7mOf.1.0" correlation vector by extending an existing value
    let correlationVector = try CorrelationVector.extend("vtul4NUsfs9Cl7mOf.1")
} catch {
    // log the error
}

// Get base of cv ("vtul4NUsfs9Cl7mOf")
let base = correlationVector.base

// Get extension of cv (0)
let ext = correlationVector.extension

// Increment existing vector and return result ("vtul4NUsfs9Cl7mOf.1.1")
let newValue = correlationVector.increment()
```
