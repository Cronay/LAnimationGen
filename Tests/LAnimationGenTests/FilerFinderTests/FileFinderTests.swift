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
    let defaultFileManager = FileManager.default
    let defaultPrinter = ConsolePrinter()

    func test_findNoFilesInEmptyDirectory() {
        let fileManager = FileManagerMock(contentsOfDirectory: [])
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        let files = fileFinder.findFiles()
        XCTAssert(files?.count == 0)
    }

    func test_findFileInDirectoryWithOneJSONFile() {
        let filesInDirectory = ["test.json"]
        let fileManager = FileManagerMock(contentsOfDirectory: filesInDirectory)
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        let files = fileFinder.findFiles()
        XCTAssert(files?.count == 1)
        XCTAssert(files == ["test"])
    }

    func test_findNoJSONFileInDirectoryWithOneNonJSONFile() {
        let filesInDirectory = ["test.xml"]
        let fileManager = FileManagerMock(contentsOfDirectory: filesInDirectory)
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        let files = fileFinder.findFiles()
        XCTAssert(files?.count == 0)
    }

    func test_findOneJSONFileInDirectoryWithAnotherFileType() {
        let filesInDirectory = ["a.json", "b.xml"]
        let fileManager = FileManagerMock(contentsOfDirectory: filesInDirectory)
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        let files = fileFinder.findFiles()
        XCTAssert(files?.count == 1)
        XCTAssert(files == ["a"])
    }

    func test_findThreeJSONFileInDirectoryWithThreeJSONFiles() {
        let filesInDirectory = ["a.json", "b.json", "c.json"]
        let fileManager = FileManagerMock(contentsOfDirectory: filesInDirectory)
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        let files = fileFinder.findFiles()
        XCTAssert(files?.count == 3)
        XCTAssert(files == ["a", "b", "c"])
    }

    func test_findJSONFileWithMultipleDotsInName() {
        let filesInDirectory = ["a.b.json"]
        let fileManager = FileManagerMock(contentsOfDirectory: filesInDirectory)
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        let files = fileFinder.findFiles()
        XCTAssert(files?.count == 1)
        XCTAssert(files == ["a.b"])
    }

    func test_ignoreFilesWithoutExtensionInName() {
        let filesInDirectory = ["a", "b+c", "a-d"]
        let fileManager = FileManagerMock(contentsOfDirectory: filesInDirectory)
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        let files = fileFinder.findFiles()
        XCTAssert(files?.count == 0)
    }

    func test_orderOfFoundJSONFiles() {
        let filesInDirectory = ["b.json", "a.json"]
        let fileManager = FileManagerMock(contentsOfDirectory: filesInDirectory)
        let fileFinder = FileFinder(inputPath: defaultInputPath,
                                    fileManager: fileManager,
                                    printer: defaultPrinter)
        let files = fileFinder.findFiles()
        XCTAssert(files == ["a", "b"])
    }
}
