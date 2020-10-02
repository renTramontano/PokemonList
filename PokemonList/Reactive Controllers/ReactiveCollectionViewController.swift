import UIKit

class ReactiveCollectionViewController<T>: CollectionViewController {
    private let viewModel: ViewModel<T>
    var model: T? = nil
    
    let navigator: Navigator

    init(navigator: Navigator, viewModel: ViewModel<T>) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.subscribe(onNext: { model in
            self.model = model
            self.render()
        })
    }

    func render() {
        fatalError("Must Override")
    }
}
