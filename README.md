
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

# Usage

For general info on correlation vector, refer to [spec](https://microsoft.sharepoint.com/:w:/t/OneCollector/EUy_CKFrDeNBvqOe7ru42oEBjVaqs7kMJkxbF09o7Dic-w?rtime=0bHE72sA10g).

## Init new vector

```swift
let correlationVector = CorrelationVector() // Implicit v1 creation
let correlationVectorV1 = CorrelationVector(.v1)
let correlationVectorV2 = CorrelationVector(.v2)
```

## Create new vector via extending existing vector

```swift
let correlationVector = try CorrelationVector.extend("vtul4NUsfs9Cl7mOf.1") // "vtul4NUsfs9Cl7mOf.1.0"
```

## Spin

**NOTE-:** Spin operator can only be used on v2 correlation vectors

```swift
let correlationVector = CorrelationVectorV2()
let params = SpinParameters(interval: SpinCounterInterval.fine, periodicity: SpinCounterPeriodicity.short, entropy: SpinEntropy.two)
let spinCorrelationVector = try CorrelationVectorV2.spin(correlationVector.value, params)
```

## General methods

```swift
let correlationVector = try CorrelationVector.extend("vtul4NUsfs9Cl7mOf.1") // "vtul4NUsfs9Cl7mOf.1.0"
let vBase = correlationVector.base // "vtul4NUsfs9Cl7mOf"
let vExtension = correlationVector.extension // 0
let vIncrement = correlationVector.increment() // will return "vtul4NUsfs9Cl7mOf.1"
```