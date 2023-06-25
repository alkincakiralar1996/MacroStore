import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum AssociatedValueMacroError: CustomStringConvertible, Error {
    case onlyApplicableToEnum
    case onlyWorksForEnumsThatHasAssociatedValues

    var description: String {
        switch self {
        case .onlyApplicableToEnum:
            "@AssociatedValue can only be applied to an enum"
        case .onlyWorksForEnumsThatHasAssociatedValues:
            "@AssociatedValue can only be applied to an enum that has associated values of cases"
        }
    }
}

public struct AssociatedValueMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
            throw AssociatedValueMacroError.onlyApplicableToEnum
        }

        let caseDecls = enumDecl.memberBlock.members.compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
        
        let associatedEnumDecls = caseDecls.filter { $0.elements.first?.associatedValue != nil }
        
        guard !associatedEnumDecls.isEmpty else {
            throw AssociatedValueMacroError.onlyWorksForEnumsThatHasAssociatedValues
        }
        
        return associatedEnumDecls.map { enumCase in
            let caseName = getCaseName(by: enumCase)
            let associatedType = getAssociatedType(by: enumCase)
            
            return """
            var \(raw: caseName)Value: \(raw: associatedType)? {
                if case let .\(raw: caseName)(value) = self {
                    value
                } else {
                    nil
                }
            }
            """
        }
    }
    
    private static func getCaseName(by enumCase: EnumCaseDeclSyntax) -> String {
        return "\(enumCase.elements.first!.identifier)"
    }
    
    private static func getAssociatedType(by enumCase: EnumCaseDeclSyntax) -> String {
        let associatedTypeValues = enumCase.elements.first!.associatedValue!.parameterList.map { $0.type }
                
        return associatedTypeValues.count == 1
        ? "\(associatedTypeValues.first!)"
        : "(\(associatedTypeValues.map { "\($0)" }.joined(separator: ", ")))"
    }
}


@main
struct MacroStorePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AssociatedValueMacro.self,
    ]
}
