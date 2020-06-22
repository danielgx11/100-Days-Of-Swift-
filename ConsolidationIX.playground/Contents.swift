import UIKit

// Challenge I

extension UIView {
    func bounceOut(duration: Double) {
        self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [unowned self] _ in
            self.transform = .identity
        }
    }
}

// Challenge II

extension Int {
    func repeats(_ closure: () -> Void) {
        guard self > 0 else { return }
        for _ in 0 ... self {
            closure()
        }
    }
}

// Challenge III

extension Array where Element: Comparable {
    mutating func removeContent(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}

var array = ["Daniel", "Gomes", "Xavier"]
array.removeContent(item: "Daniel")
debugPrint(array)
