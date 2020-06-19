import UIKit


// Challenge 01

extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return self
        } else {
            return prefix + self
        }
    }
}
let testString = "This is a test string"
let car = "Benz2"

// Challenge 02

extension String {
    var isNumeric: Bool {
        return Double(self) != nil
    }
    
    func numeric() -> Bool {
        for letter in self {
            let string = String(letter)
            if Double(string) != nil {
                return true
            }
        }
        return false
    }
}

// Challenge 03

extension String {
    var lines: [String] {
        return self.components(separatedBy: " ")
    }
}

testString.lines

car.numeric()

car.withPrefix("Mercedes")

let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

let languages = ["Python", "Ruby", "Swift"]
let input = "Swift is like Objective-C without the C"

languages.contains(where: input.contains)

extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        return false
    }
}

input.containsAny(of: languages)

/// Read 4th letter in string

let name = "Taylor"

let letter = name[name.index(name.startIndex, offsetBy: 3)]

/// OR

extension String { /// Never use
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let test = name[3]
