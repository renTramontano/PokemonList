import UIKit

final class LoadCellsView: UIView {
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addContentView(activityIndicatorView)
    }
}

extension LoadCellsView {
    static func create() -> LoadCellsView {
        let cell = LoadCellsView()
        cell.activityIndicatorView.startAnimating()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }
}
