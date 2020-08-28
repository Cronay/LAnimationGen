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
        let sut = makeSUT(withFilesInDirectory: [])

        let foundFiles = sut.findFiles()

        XCTAssertEqual(foundFiles, [])
    }

    func test_findFileInDirectoryWithOneJSONFile() {
        let sut = makeSUT(withFilesInDirectory: ["test.json"])

        let foundFiles = sut.findFiles()

        XCTAssertEqual(foundFiles, ["test"])
    }

    func test_findNoJSONFileInDirectoryWithOneNonJSONFile() {
        let sut = makeSUT(withFilesInDirectory: ["test.xml"])

        let foundFiles = sut.findFiles()

        XCTAssertEqual(foundFiles, [])
    }

    func test_findOneJSONFileInDirectoryWithAnotherFileType() {
        let sut = makeSUT(withFilesInDirectory: ["a.json", "b.xml"])

        let foundFiles = sut.findFiles()

        XCTAssertEqual(foundFiles, ["a"])
    }

    func test_findThreeJSONFileInDirectoryWithThreeJSONFiles() {
        let sut = makeSUT(withFilesInDirectory: ["a.json", "b.json", "c.json"])

        let foundFiles = sut.findFiles()

        XCTAssertEqual(foundFiles, ["a", "b", "c"])
    }

    func test_findJSONFileWithMultipleDotsInName() {
        let sut = makeSUT(withFilesInDirectory: ["a.b.json"])

        let foundFiles = sut.findFiles()

        XCTAssertEqual(foundFiles, ["a.b"])
    }

    func test_ignoreFilesWithoutExtensionInName() {
        let sut = makeSUT(withFilesInDirectory: ["a", "b+c", "a-d"])

        let foundFiles = sut.findFiles()

        XCTAssertEqual(foundFiles, [])
    }

    func test_orderOfFoundJSONFiles() {
        let sut = makeSUT(withFilesInDirectory: ["b.json", "a.json"])

        let foundFiles = sut.findFiles()

        XCTAssertEqual(foundFiles, ["a", "b"])
    }

    // MARK: - Helpers

    private func makeSUT(withFilesInDirectory files: [String]) -> FileFinder {
        let fileManager = FileManagerMock(contentsOfDirectory: files)
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        return fileFinder
    }
}
