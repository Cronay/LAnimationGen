//
//  FileFinder.swift
//  LAnimationGen
//
//  Created by Cronay on 06.08.20.
//

import Foundation

final class FileFinder {
    let inputPath: String
    let fileManager: FileManager
    let printer: Printer

    init(inputPath: String, fileManager: FileManager, printer: Printer) {
        self.inputPath = inputPath
        self.fileManager = fileManager
        self.printer = printer
    }

    func findFiles() -> [String]? {
        guard let fileList = getWholeFileListFromDirectory() else {
            return nil
        }
        let filteredFileList = filterListForJSONFiles(fileList: fileList)
        let listWithTrimmedNames = trimFileNamesInList(fileList: filteredFileList)
        return listWithTrimmedNames.sorted(by: <)
    }

    private func getWholeFileListFromDirectory() -> [String]? {
        do {
            let inputContent = try fileManager.contentsOfDirectory(atPath: inputPath)
            return inputContent
        } catch {
            printer.error(error.localizedDescription)
            return nil
        }
    }

    private func filterListForJSONFiles(fileList: [String]) -> [String] {
        let fileExtensionString = ".json"
        return fileList.filter {
            $0.suffix(fileExtensionString.count) == fileExtensionString
        }
    }

    private func trimFileNamesInList(fileList: [String]) -> [String] {
        return fileList.compactMap {
            let fileNameCountWithExtension = $0.count
            let extensionCount = ".json".count
            let fileName = $0.prefix(fileNameCountWithExtension - extensionCount)
            return String(fileName)
        }
    }
}
