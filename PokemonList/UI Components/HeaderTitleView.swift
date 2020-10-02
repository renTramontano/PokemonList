import UIKit

final class HeaderTitleView: UIView {
    private var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
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
        backgroundColor = .white
        addContentView(titleLable, top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension HeaderTitleView {
    static func create(with title: String) -> HeaderTitleView {
        let view = HeaderTitleView()
        view.titleLable.text = title
        return view
    }
}
