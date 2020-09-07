//
//  File.swift
//  
//
//  Created by Cronay on 06.09.20.
//

import XCTest

class NameFormatter {
    static func format(_ names: [String]) -> [String] {
        return names.map { currentName in
            if currentName.contains("_") {
                let formattedString = formatUnderScores(outOf: currentName)
                return formattedString
            } else if let firstChar = currentName.first, firstChar.isUppercase {
                return currentName.lowercased()
            } else {
                return currentName
            }
        }
    }

    private static func formatUnderScores(outOf name: String) -> String {
        let stringParts = name.split(separator: "_").map(String.init)
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

class NameFormatterTests: XCTestCase {

    func test_format_doesAlterAlreadyFormattedNames() {
        let alreadyFormattedNames = ["aNameWithCamelCase", "anamewithoutanyseparation", "aNAMEWITHALLCAPITALBUTFIRST"]

        let newlyFormattedNames = NameFormatter.format(alreadyFormattedNames)

        XCTAssertEqual(alreadyFormattedNames, newlyFormattedNames)
    }

    func test_format_nameWithAnUnderScoreIsGivenCamelCaseWithoutUnderscore() {
        let nameWithUnderScore = "a_name"

        let formattedName = NameFormatter.format([nameWithUnderScore])

        XCTAssertEqual(["aName"], formattedName)
    }

    func test_format_emptyListOfNamesReturnsEmptyList() {
        let formattedName = NameFormatter.format([])

        XCTAssertEqual([], formattedName)
    }

    func test_format_listWithASingleEmptyName() {
        let formattedName = NameFormatter.format([""])

        XCTAssertEqual([""], formattedName)
    }

    func test_format_nameWithAnUnderScoreAtTheBeginning() {
        let formattedName = NameFormatter.format(["_name"])

        XCTAssertEqual(["name"], formattedName)
    }

    func test_format_nameWithAnUnderScoreAtTheEnd() {
        let formattedName = NameFormatter.format(["name_"])

        XCTAssertEqual(["name"], formattedName)
    }

    func test_format_capitalizedNameIsNotCapitalizedAfterwards() {
        let formattedName = NameFormatter.format(["Name"])

        XCTAssertEqual(["name"], formattedName)
    }

    func test_format_uppercasedNameIsNotLowercasedAfterwards() {
        let formattedName = NameFormatter.format(["NAME"])

        XCTAssertEqual(["name"], formattedName)
    }

}
