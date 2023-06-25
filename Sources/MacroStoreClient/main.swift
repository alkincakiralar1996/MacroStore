import MacroStore

@AssociatedValue
enum ViewModelState {
    case loading
    case loaded(data: Data, externalData: ExternalData)
    case failure(error: String)
    case empty(EmptyState)
}

struct Data {
    let id: Int
}

struct ExternalData {
    let id: Int
}

enum EmptyState {
    case withImage
}

var _viewModelState: ViewModelState = .loading
_viewModelState = .empty(.withImage)

if _viewModelState.emptyValue == .withImage {
    
}

let _ = _viewModelState.loadedValue?.0
let _ = _viewModelState.loadedValue?.1

