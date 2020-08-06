//
//  File.swift
//  
//
//  Created by Cronay on 06.08.20.
//

import Foundation

class FileManagerMock: FileManager {

    var contentsOfDirectory: [String]

    convenience init(contentsOfDirectory: [String]) {
        self.init()
        self.contentsOfDirectory = contentsOfDirectory
    }

    private override init() {
        self.contentsOfDirectory = []
        super.init()
    }

    override func contentsOfDirectory(atPath path: String) throws -> [String] {
        return contentsOfDirectory
    }
}
