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
        let (sut, _) = makeSUT(withErrorInFileManager: anyError())

        let foundFiles = sut.findFiles()

        XCTAssertNil(foundFiles)
    }

    func test_fileManagerReturnsError_printErrorToConsole() {
        let error = anyError()
        let (sut, printer) = makeSUT(withErrorInFileManager: error)

        _ = sut.findFiles()

        XCTAssertEqual(printer.receivedErrorMessage, error.localizedDescription)
        XCTAssertNil(printer.receivedPrintMessage)
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
        let printer = PrinterSpy()
        let fileFinder = FileFinder(inputPath: ".", fileManager: fileManager, printer: printer)
        return fileFinder
    }

    private func makeSUT(withErrorInFileManager error: Error) -> (sut: FileFinder, printer: PrinterSpy) {
        let fileManager = FileManagerMock(result: .error(error))
        let printer = PrinterSpy()
        let sut = FileFinder(inputPath: ".", fileManager: fileManager, printer: printer)
        return (sut, printer)
    }

    private func anyError() -> Error {
        return NSError(domain: "any error", code: 0)
    }

    private class FileManagerMock: FileManager {
        enum Result {
            case success([String])
            case error(Error)
        }

        private let result: Result

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

    private class PrinterSpy: Printer {
        var receivedPrintMessage: String?
        var receivedErrorMessage: String?

        func print(_ input: String) {
            receivedPrintMessage = input
        }

        func error(_ input: String) {
            receivedErrorMessage = input
        }
    }
}
