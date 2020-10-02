import UIKit

final class TagLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(){
        self.font = UIFont.boldSystemFont(ofSize: 20)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        self.layer.cornerRadius = 30/2
        self.clipsToBounds = true
        self.textColor = .white
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 16 + 16, height: size.height)
    }
}
