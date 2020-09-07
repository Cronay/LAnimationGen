//
//  File.swift
//  
//
//  Created by Cronay on 06.09.20.
//

import XCTest

class NameFormatter {
    static func format(_ names: [String]) -> [String] {
        return names
    }
}

class NameFormatterTests: XCTestCase {

    func test_format_doesAlterAlreadyFormattedNames() {
        let alreadyFormattedNames = ["aNameWithCamelCase", "anamewithoutanyseparation", "aNAMEWITHALLCAPITALBUTFIRST"]

        let newlyFormattedNames = NameFormatter.format(alreadyFormattedNames)

        XCTAssertEqual(alreadyFormattedNames, newlyFormattedNames)
    }
}
