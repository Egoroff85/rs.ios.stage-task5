import UIKit

class MessageDecryptor: NSObject {
    var stack: [(Int, String)] = []
    var result: String = ""
    var num: Int = 0
    
    func decryptMessage(_ message: String) -> String {
        var encryptedStr = message
        
        if encryptedStr.hasPrefix("[") && encryptedStr.hasSuffix("]") {
            encryptedStr.removeFirst()
            encryptedStr.removeLast()
        }
        
        for char in Array(encryptedStr) {
            if char.isLetter {
                self.result += String(char)
            } else if char.isNumber {
                self.num = self.num * 10 + Int(String(char))!
            } else if char == "[" {
                self.stack.append((self.num, self.result))
                self.num = 0
                self.result = ""
            } else if char == "]" {
                let temp = self.stack.popLast()!
                var repeatStr = ""
                for _ in 0..<temp.0 {
                    repeatStr += self.result
                }
                self.result = temp.1 + repeatStr
            }
        }
        return self.result
    }
}
