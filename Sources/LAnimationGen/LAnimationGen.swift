//
//  LAnimationGen.swift
//  LAnimationGen
//
//  Created by Cronay on 05.08.20.
//

import ArgumentParser
import Foundation

struct LAnimationGen: ParsableCommand {

    @Option()
    var input: String

    @Option()
    var output: String

    func run() throws {
        let fileManager = FileManager.default
        let printer = ConsolePrinter()
        let fileFinder = FileFinder(inputPath: input, fileManager: fileManager, printer: printer)

        guard let foundFiles = fileFinder.findFiles() else { return }

        let generatedCode = CodeGenerator().generate(fileList: foundFiles)

        do {
            try generatedCode.write(toFile: output + "/LAnimation.swift", atomically: true, encoding: .utf8)
        } catch {
            printer.error(error.localizedDescription)
        }
    }
}
