import UIKit

final class PokemonDetailViewController: ReactiveTableViewController<PokemonModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
}

extension PokemonDetailViewController {
    func render() {
        guard let state = model else { return }
        renderer([Section(header: ViewNode(HeaderImageView.create(with: state))),
                  Section(header: ViewNode(CarouselView.create(with: state))),
                  Section(header: ViewNode(HeaderTitleView.create(with: "Base Stats")),
                          cells: state.stats.map { CellNode(StatView.create(with: $0)) })])
    }
}

extension PokemonDetailViewController {
    static func create(with navigator: Navigator, model: PokemonModel) -> UIViewController {
        let viewModel = ViewModel.init(value: model)
        let controller = PokemonDetailViewController(navigator: navigator, viewModel: viewModel)
        controller.title = model.name
        return controller
    }
}
