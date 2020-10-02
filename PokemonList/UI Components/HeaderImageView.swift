import UIKit

final class HeaderImageView: UIView {
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(stackView)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}

extension HeaderImageView {
    static func create(with model: PokemonModel) -> HeaderImageView {
        let headerView = HeaderImageView()
        headerView.titleLabel.text = model.name
        headerView.backgroundColor = model.types.first?.color
        model.types.forEach {
            let label = TagLabel()
            label.text = $0.name
            headerView.stackView.addArrangedSubview(label)
        }
        headerView.stackView.addArrangedSubview(UIView())

        return headerView
    }
}
