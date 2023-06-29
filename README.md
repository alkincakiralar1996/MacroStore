# MacroStore :rocket:

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

## Note :
    You can only use this repository with Xcode 15 and higher version
    
## Author
### ✨If this project reduce your development time please Give me a STAR✨

Alkin Cakiralar, cakiralaralkin@gmail.com

## License

MacroStore is available under the MIT license. See the LICENSE file for more info.
