//
//  File.swift
//  
//
//  Created by Cronay on 06.08.20.
//

import Foundation

class ConsolePrinter: Printer {
    func print(_ input: String) {
        Swift.print(input)
    }

    func error(_ input: String) {
        fputs("Error: \(input)", stderr)
    }
}
