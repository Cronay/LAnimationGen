//
//  File.swift
//  
//
//  Created by Cronay on 06.09.20.
//

import XCTest
@testable import LAnimationGen

class NameFormatterTests: XCTestCase {

    func test_format_emptyListOfNamesReturnsEmptyList() {
        let formattedName = NameFormatter.format([])

        XCTAssertEqual([], formattedName)
    }

    func test_format_listWithASingleEmptyName() {
        let formattedName = NameFormatter.format([""])

        XCTAssertEqual([""], formattedName)
    }

    func test_format_capitalizedNameIsNotCapitalizedAfterwards() {
        let formattedName = NameFormatter.format(["Name"])

        XCTAssertEqual(["name"], formattedName)
    }

    func test_format_uppercasedNameIsNotLowercasedAfterwards() {
        let formattedName = NameFormatter.format(["NAME"])

        XCTAssertEqual(["name"], formattedName)
    }

    func test_format_doesAlterAlreadyFormattedNames() {
        let alreadyFormattedNames = ["aNameWithCamelCase", "anamewithoutanyseparation", "aNAMEWITHALLCAPITALBUTFIRST"]

        let newlyFormattedNames = NameFormatter.format(alreadyFormattedNames)

        XCTAssertEqual(alreadyFormattedNames, newlyFormattedNames)
    }

    func test_format_underScoreCasesRepresentingAllOtherSymbols() {
        let namesWithUnderScore = ["a_name", "_name", "name_", "a_name_is_a_name", "a__name"]

        let formattedName = NameFormatter.format(namesWithUnderScore)

        XCTAssertEqual(["aName", "name", "name", "aNameIsAName", "aName"], formattedName)
    }

    func test_format_excludedParenthesis() {
        let namesWithParenthesis = ["a(name", "ana)me", "a]name", "ana[me", "a{name", "ana}me"]

        let formattedNames = NameFormatter.format(namesWithParenthesis)

        XCTAssertEqual(["aname", "aname", "aname", "aname", "aname", "aname"], formattedNames)
    }
}
