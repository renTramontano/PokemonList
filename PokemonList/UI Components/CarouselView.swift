import UIKit

final class CarouselView: UIView {
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.heightAnchor.constraint(equalToConstant: 300).isActive = true
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.isPagingEnabled = true
        return scrollview
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var baseView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pageControl: UIPageControl = {
        let pagecontrol = UIPageControl()
        pagecontrol.translatesAutoresizingMaskIntoConstraints = false
        return pagecontrol
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(baseView)
        baseView.addSubview(pageControl)
        addContentView(scrollView)
        scrollView.addContentView(stackView)
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            baseView.leftAnchor.constraint(equalTo: leftAnchor),
            baseView.rightAnchor.constraint(equalTo: rightAnchor),
            baseView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: baseView.centerXAnchor)
        ])
        scrollView.delegate = self
    }
    
    private func addImageView(with imagesURL: URL?) {
        guard let url = imagesURL else { return }
        let imageView = UIImageView()
        imageView.contentMode = ContentMode.scaleAspectFit
        stackView.addArrangedSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        DispatchQueue.global(qos: .background).async {
            let image = UIImage.getImageBy(url: url)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}

extension CarouselView {
    static func create(with model: PokemonModel) -> CarouselView {
        let carouselView = CarouselView()
        model.sprites.forEach { carouselView.addImageView(with: $0) }
        carouselView.backgroundColor = model.types.first?.color
        carouselView.pageControl.numberOfPages = model.sprites.count
        carouselView.pageControl.currentPage = 0
        carouselView.pageControl.pageIndicatorTintColor = model.types.first?.color.withAlphaComponent(0.3)
        carouselView.pageControl.currentPageIndicatorTintColor = model.types.first?.color
        return carouselView
    }
}

extension CarouselView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        switch scrollView.contentOffset.x {
            case 0.0: self.pageControl.currentPage = 0
            case width: self.pageControl.currentPage = 1
            case width*2: self.pageControl.currentPage = 2
            case width*3: self.pageControl.currentPage = 3
            case width*4: self.pageControl.currentPage = 4
            case width*5: self.pageControl.currentPage = 5
            case width*6: self.pageControl.currentPage = 6
            default: break
        }
    }
}
