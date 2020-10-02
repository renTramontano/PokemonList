import UIKit

extension UIImage {
    static func getImageBy(url: URL?) -> UIImage? {
        guard let url = url, let data = try? Data(contentsOf: url) else { return UIImage() }
        return UIImage(data: data)
    }
}
