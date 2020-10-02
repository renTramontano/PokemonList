import UIKit

final class StatView: UIView {
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()

    private var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.widthAnchor.constraint(equalToConstant: 150).isActive = true
        label.textColor = .darkGray
        return label
    }()

    private var baseStatLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()

    private var progressView: UIProgressView = {
        let progressview = UIProgressView()
        progressview.heightAnchor.constraint(equalToConstant: 5).isActive = true
        progressview.progressTintColor = .green
        return progressview
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white
        addContentView(stackView, top: 16, left: 16, bottom: 16, right: 16)
        stackView.addArrangedSubview(titleLable)
        stackView.addArrangedSubview(baseStatLable)
        stackView.addArrangedSubview(progressView)
    }
}

extension StatView {
    static func create(with stat: PokemonStat) -> StatView {
        let view = StatView()
        view.titleLable.text = stat.name
        view.baseStatLable.text = String(stat.base ?? 0)
        view.progressView.progress = Float(stat.base ?? 0) / 100
        view.progressView.progressTintColor = view.progressView.progress > 0.5 ? .green : .red
        return view
    }
}
