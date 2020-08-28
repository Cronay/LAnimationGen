//
//  CodeGeneratorTests.swift
//  LAnimationGen
//
//  Created by Cronay on 06.08.20.
//

import XCTest
@testable import LAnimationGen

class CodeGeneratorTests: XCTestCase {

    let codeStart = """
                    import Foundation
                    import Lottie

                    enum LAnimation {\n
                    """

    let codeEnd = "}\n"

    func test_generateClassWithoutFile() {
        let codeGenerator = CodeGenerator()
        let code = codeGenerator.generate(fileList: [])
        XCTAssertEqual(code, codeStart + codeEnd)
    }

    func test_generateClassWithOneFile() {
        let codeGenerator = CodeGenerator()
        let generatedFileAccessor = "    internal static let a = Animation.named(\"a\")\n"
        let code = codeGenerator.generate(fileList: ["a"])
        let expectedOutcome = codeStart + "\n" + generatedFileAccessor + codeEnd
        XCTAssertEqual(code, expectedOutcome)
    }
}
