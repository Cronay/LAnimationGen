//
//  FileFinderTests.swift
//  LAnimationGenTests
//
//  Created by Cronay on 06.08.20.
//

import XCTest
@testable import LAnimationGen

class FileFinderTests: XCTestCase {

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

    func test_fileManagerReturnsError_returnsNil() {
        let error = NSError(domain: "any error", code: 0)
        let fileManager = FileManagerMock(result: .error(error))
        let printer = ConsolePrinter()
        let sut = FileFinder(inputPath: ".", fileManager: fileManager, printer: printer)

        let foundFiles = sut.findFiles()

        XCTAssertNil(foundFiles)
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
        let fileManager = FileManagerMock(result: .success(files))
        let printer = ConsolePrinter()
        let fileFinder = FileFinder(inputPath: ".",
                                    fileManager: fileManager,
                                    printer: printer)
        return fileFinder
    }

    private class FileManagerMock: FileManager {

        enum Result {
            case success([String])
            case error(Error)
        }

        var result: Result

        init(result: Result) {
            self.result = result
            super.init()
        }

        override func contentsOfDirectory(atPath path: String) throws -> [String] {
            switch result {
            case .success(let contentOfDirectory):
                return contentOfDirectory
            case .error(let error):
                throw error
            }
        }
    }
}
