# MacroStore :rocket:

[![Swift 5.0](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-ios-blue.svg?style=flat)]([https://cocoapods.org/pods/iOSDropDown](https://github.com/alkincakiralar1996/MacroStore))

Bunch of Swift Macros
<br/>
I'll gather plenty of macros which can be helpfull for swift development to this repository

_**Here are the existing and further macros that you can integrate with in your project**_

- @AssociatedValue
- @DummyData ( Developing )

<br/>

## @AssociatedValue

It helps you simply extract Associated Values from enum

### Usage

Define <b>@AssociatedValue</b> macros to your enum and extract the cases appended <b>"value"</b> keyword as below

```Swift
@AssociatedValue
enum ViewModelState {
    case loading
    case loaded(data: Data, externalData: ExternalData)
    case failure(error: String)
    case empty(EmptyState)
}

let _ = _viewModelState.emptyValue // EmptyState?
let _ = _viewModelState.loadedValue?.0 // Data?
let _ = _viewModelState.loadedValue?.1 // ExternalData?
let _ = _viewModelState.failureValue // String?
```

---

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding MacroStore as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/alkincakiralar1996/MacroStore.git", branch: "main")
]
```

## Note :
    You can only use this repository with Xcode 15 and higher version
    
## Author
### ✨If this project reduce your development time please Give me a STAR✨

Alkin Cakiralar, cakiralaralkin@gmail.com

## License

MacroStore is available under the MIT license. See the LICENSE file for more info.
