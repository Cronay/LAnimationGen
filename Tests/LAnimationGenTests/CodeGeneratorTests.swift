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

                    enum LAnimation {
                    """

    let codeEnd = "}\n"

    func test_generateClassWithoutFile() {
        let codeGenerator = CodeGenerator()
        let code = codeGenerator.generate(fileList: [])
        XCTAssertEqual(codeStart + codeEnd, code)
    }

    func test_generateClassWithOneFile() {
        let codeGenerator = CodeGenerator()
        let generatedFileAccessor = "    internal static let a = Animation.named(\"a\")"
        let code = codeGenerator.generate(fileList: ["a"])
        let expectedOutcome = codeStart + "\n"
            + generatedFileAccessor + "\n"
            + codeEnd
        XCTAssertEqual(expectedOutcome, code)
    }

    func test_generatedClassWithMultipleFiles() {
        let codeGenerator = CodeGenerator()

        let code = codeGenerator.generate(fileList: ["a", "b", "c"])

        let firstGeneratedLine = "    internal static let a = Animation.named(\"a\")"
        let secondGeneratedLine = "    internal static let b = Animation.named(\"b\")"
        let thirdGeneratedLine = "    internal static let c = Animation.named(\"c\")"

        let expectedOutcome = codeStart + "\n"
            + firstGeneratedLine + "\n"
            + secondGeneratedLine + "\n"
            + thirdGeneratedLine + "\n"
            + codeEnd


        XCTAssertEqual(expectedOutcome, code)
    }
}
