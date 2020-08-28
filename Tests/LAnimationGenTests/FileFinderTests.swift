//
//  FileFinderTests.swift
//  LAnimationGenTests
//
//  Created by Cronay on 06.08.20.
//

import XCTest
@testable import LAnimationGen

class FileFinderTests: XCTestCase {

    let defaultInputPath = "."
    let defaultPrinter = ConsolePrinter()

    func test_findNoFilesInEmptyDirectory() {
        expectSUT(withFilesInDirectory: [], toReturn: [])
    }

    func test_findFileInDirectoryWithOneJSONFile() {
        expectSUT(withFilesInDirectory: ["test.json"], toReturn: ["test"])
    }

    func test_findNoJSONFileInDirectoryWithOneNonJSONFile() {
        expectSUT(withFilesInDirectory: ["test.xml"], toReturn: [])
    }

    func test_findOneJSONFileInDirectoryWithAnotherFileType() {
        expectSUT(withFilesInDirectory: ["a.json", "b.xml"], toReturn: ["a"])
    }

    func test_findThreeJSONFileInDirectoryWithThreeJSONFiles() {
        expectSUT(withFilesInDirectory: ["a.json", "b.json", "c.json"], toReturn: ["a", "b", "c"])
    }

    func test_findJSONFileWithMultipleDotsInName() {
        expectSUT(withFilesInDirectory: ["a.b.json"], toReturn: ["a.b"])
    }

    func test_ignoreFilesWithoutExtensionInName() {
        expectSUT(withFilesInDirectory: ["a", "b+c", "a-d"], toReturn: [])
    }

    func test_orderOfFoundJSONFiles() {
        expectSUT(withFilesInDirectory: ["b.json", "a.json"], toReturn: ["a", "b"])
    }

    // MARK: - Helpers

    private func expectSUT(withFilesInDirectory files: [String],
                           toReturn expectedFiles: [String],
                           file: StaticString = #file,
                           line: UInt = #line) {
        let sut = makeSUT(withFilesInDirectory: files)

        let foundFiles = sut.findFiles()

        XCTAssertEqual(expectedFiles, foundFiles, file: file, line: line)
    }

    private func makeSUT(withFilesInDirectory files: [String]) -> FileFinder {
        let fileManager = FileManagerMock(contentsOfDirectory: files)
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        return fileFinder
    }
}
