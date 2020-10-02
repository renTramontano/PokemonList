import UIKit

final class PokemonCell: UIView {
    var action: (()->Void)?

    private let pokeImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "poke")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        return view
    }()

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private var iconImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addContentView(pokeImageView, top: 50, left: 50, bottom: 50, right: 50)
        addContentView(stackView, top: 16, left: 16, bottom: 16, right: 16)
        addContentView(activityIndicatorView)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(nameLabel)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle)))
        layer.cornerRadius = 32
        clipsToBounds = true
    }

    @objc func handle() {
        action?()
    }
}

extension PokemonCell {
    static func create(with model: PokemonModel, action: ((PokemonModel)->())? = nil) -> PokemonCell {
        let cell = PokemonCell()
        cell.activityIndicatorView.startAnimating()
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.nameLabel.text = model.name
        cell.backgroundColor = model.types.first?.color
        cell.action = { action?(model) }

        DispatchQueue.global(qos: .background).async {
            let image = UIImage.getImageBy(url: model.defaultImageURL)
            DispatchQueue.main.async {
                cell.activityIndicatorView.stopAnimating()
                cell.iconImageView.image = image
            }
        }
        return cell
    }
}


