import UIKit

extension UIView {
    public func addContentView(_ subView: UIView, top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor, constant: top),
            subView.leftAnchor.constraint(equalTo: leftAnchor, constant: left),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottom),
            subView.rightAnchor.constraint(equalTo: rightAnchor, constant: -right)])
    }
}
