//
//  LAnimationGen.swift
//  LAnimationGen
//
//  Created by Cronay on 12.02.20.
//  Copyright © 2020 Yannic Borgfeld. All rights reserved.
//

import Foundation

class LAnimationGen {
    
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        if isHelpRequested() || CommandLine.argc < 2 {
            consoleIO.printUsage()
        } else {
            guard let inputPathString = findInput() else {
                consoleIO.writeMessage("Please specify an input directory:")
                consoleIO.printUsage()
                return
            }
            guard let outputPathString = findOutput() else {
                consoleIO.writeMessage("Please specify an input directory:")
                consoleIO.printUsage()
                return
            }
            
            let fileManager = FileManager.default
            do {
                let inputContent = try fileManager.contentsOfDirectory(atPath: inputPathString)
                var fileNames = [String]()
                for file in inputContent {
                    if file.suffix(5) == ".json" {
                        guard let fileName = file.split(separator: ".").first else {
                            consoleIO.writeMessage("The file name is wierd")
                            return
                        }
                        
                        let actualFileName = String(fileName)
                        fileNames.append(actualFileName)
                    }
                }
                var toBeGeneratedString = """
                                          import Foundation
                                          import Lottie
                                          
                                          enum LAnimation {
                                          
                                          """
                
                for file in fileNames {
                    var variableNameParts = file.split(separator: "_").map(String.init)
                    let variableName = combineStringParts(stringArray: &variableNameParts)
                    toBeGeneratedString.append(contentsOf: "    internal static let \(variableName) = Animation.named(\"\(file)\")\n")
                }
                toBeGeneratedString.append(contentsOf: "}\n")
                try toBeGeneratedString.write(toFile: outputPathString + "/LAnimation.swift", atomically: true, encoding: .utf8)
            } catch {
                print(error)
            }
        }
    }
    
    func combineStringParts(stringArray: inout [String]) -> String {
        if stringArray.count > 1, let lastPartOfString = stringArray.popLast() {
            return combineStringParts(stringArray: &stringArray) + lastPartOfString.capitalized
        } else if stringArray.count == 1 {
            return stringArray[0].lowercased()
        } else {
            return ""
        }
    }
    
    func findInput() -> String? {
        var inputString: String?
        for i in 0..<4 {
            let currentArgument = CommandLine.arguments[i]
            if currentArgument == "--input" {
                inputString = CommandLine.arguments[i+1]
            }
        }
        return inputString
    }
    
    func findOutput() -> String? {
        var outputString: String?
        for i in 0..<4 {
            let currentArgument = CommandLine.arguments[i]
            if currentArgument == "--output" {
                outputString = CommandLine.arguments[i+1]
            }
        }
        return outputString
    }
    
    func isHelpRequested() -> Bool {
        return CommandLine.arguments.contains("--help")
    }
}
