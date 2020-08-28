//
//  CodeGenerator.swift
//  LAnimationGen
//
//  Created by Cronay on 06.08.20.
//

import Foundation

class CodeGenerator {

    let codeStart = """
                    import Foundation
                    import Lottie

                    enum LAnimation {\n
                    """

    let codeEnd = "}\n"

    func generate(fileList: [String]) -> String {
        let animationAccessors = generateFileAccessors(fileList: fileList)
        return codeStart + animationAccessors + codeEnd
    }

    private func generateFileAccessors(fileList: [String]) -> String {
        let fileAccessors = fileList.reduce("") { result, current -> String in
            return result + "\n" + "    internal static let \(current) = Animation.named(\"\(current)\")\n"
        }
        return fileAccessors
    }
}
