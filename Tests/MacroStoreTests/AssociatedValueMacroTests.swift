import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import MacroStoreMacros

let testMacros: [String: Macro.Type] = [
    "AssociatedValue": AssociatedValueMacro.self
]

final class MacroStoreTests: XCTestCase {
    func testAssociatedValue() {
        assertMacroExpansion(
            """
            @AssociatedValue
            enum ViewModelState {
                case loading
                case loaded(data: Data, externalData: ExternalData)
                case failure(error: String)
                case empty(EmptyState)
            }
            """,
            expandedSource:
            """
            
            enum ViewModelState {
                case loading
                case loaded(data: Data, externalData: ExternalData)
                case failure(error: String)
                case empty(EmptyState)
                var loadedValue: (Data, ExternalData)? {
                    if case let .loaded(value) = self {
                        value
                    } else {
                        nil
                    }
                }
                var failureValue: String? {
                    if case let .failure(value) = self {
                        value
                    } else {
                        nil
                    }
                }
                var emptyValue: EmptyState? {
                    if case let .empty(value) = self {
                        value
                    } else {
                        nil
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
}
