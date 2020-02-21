//
//  ConsoleIO.swift
//  LAnimationGen
//
//  Created by Cronay on 12.02.20.
//  Copyright © 2020 Yannic Borgfeld. All rights reserved.
//

import Foundation

enum OutputType {
    case error
    case standard
}

class ConsoleIO {
    
    func writeMessage(_ message: String, to outputType: OutputType = .standard) {
        switch outputType {
        case .standard:
            print(message)
        case .error:
            fputs("Error: \(message)", stderr)
        }
    }
    
    func printUsage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeMessage("usage:")
        writeMessage("\(executableName) --input <PATH_TO_INPUT> --output <PATH_TO_DESTINATION>")
        writeMessage("or")
        writeMessage("\(executableName) --help to show usage information")
    }
    
}
