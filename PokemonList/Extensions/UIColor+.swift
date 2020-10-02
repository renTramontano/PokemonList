import UIKit

extension UIColor {
    public convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(UInt8(hex >> 16 & 0xFF)) / 255,
            green: CGFloat(UInt8(hex >> 8 & 0xFF)) / 255,
            blue: CGFloat(UInt8(hex & 0xFF)) / 255,
            alpha: alpha
        )
    }
}
