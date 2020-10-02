import UIKit

final class PokemonPlaceholderCell: UIView {
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
        backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        addContentView(activityIndicatorView)
        layer.cornerRadius = 32
        clipsToBounds = true
    }
}

extension PokemonPlaceholderCell {
    static func create() -> PokemonPlaceholderCell {
        let cell = PokemonPlaceholderCell()
        cell.activityIndicatorView.startAnimating()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }
}
