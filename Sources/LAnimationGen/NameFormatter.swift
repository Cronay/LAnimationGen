//
//  File.swift
//  
//
//  Created by Cronay on 07.09.20.
//

import Foundation

class NameFormatter {

    private static let capitilizationElements: [String.Element] = ["_", "-", "."]
    private static let disallowedSymbols = Array("(){}[]")

    static func format(_ names: [String]) -> [String] {
        return names.map { currentName in
            let formattedString = formatCapitalization(at: capitilizationElements, in: currentName)
            let formattedFilteredString = formattedString.filter { !disallowedSymbols.contains($0) }
            if let firstChar = formattedFilteredString.first, firstChar.isUppercase {
                return formattedFilteredString.lowercased()
            } else {
                return formattedFilteredString
            }
        }
    }

    private static func formatCapitalization(at elements: [String.Element], in name: String) -> String {
        var currentName = name
        elements.forEach { character in
            if currentName.contains(character) {
                currentName = formatCapitilization(at: character, in: currentName)
            }
        }
        return currentName
    }

    private static func formatCapitilization(at splitSign: String.Element, in name: String) -> String {
        let stringParts = name.split(separator: splitSign).map(String.init)
        let capitalizedStringParts = capitalizeAllPartsButTheFirst(stringParts: stringParts)
        return capitalizedStringParts.reduce(into: "") { (acc, next) in
            acc.append(next)
        }
    }

    private static func capitalizeAllPartsButTheFirst(stringParts: [String]) -> [String] {
        if stringParts.count < 1 {
            return stringParts
        } else if stringParts.count < 2 {
            return stringParts.map { $0.lowercased() }
        } else {
            let first = stringParts[0]
            let remaining = Array(stringParts.dropFirst()).map { $0.capitalized }
            var result = [first]
            result.append(contentsOf: remaining)
            return result
        }
    }
}

private extension String {
    func lowercasedFirstLetter() -> String {
        return prefix(1).lowercased() + dropFirst()
    }
}
