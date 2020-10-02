import UIKit

final class PokedexViewController: ReactiveCollectionViewController<[PokemonModel]> {
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    private func showPlaceholder() {
        let placeholderCells = Array(0...20).map { _ in CellNode(PokemonPlaceholderCell.create()) }
        renderer([Section(cells: placeholderCells)])
    }

    override func render() {
        guard let state = model else { return showPlaceholder() }
        self.renderer(
            [Section(cells: state.map { CellNode(PokemonCell.create(with: $0, action: { [unowned self] in self.navigator.present(.detail($0), from: self) })) },
                     footer: ViewNode(LoadCellsView.create()))])
        
    }
}

extension PokedexViewController {
    static func create(with navigator: Navigator) -> UIViewController {
        let viewModel = navigator.services.getPokemons()
            .map { PokemonModel.create(with: $0) }
        let controller = PokedexViewController(navigator: navigator, viewModel: viewModel)
        controller.title = "Pokedex"
        return controller
    }
}

extension PokedexViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let state = model, indexPath.row == state.count/2 else { return }
        self.navigator.services.getPokemons()
            .map { PokemonModel.create(with: $0) }
            .subscribe(onNext: { newPokemons in
                self.model = state + newPokemons
                self.render()
            })
    }
}
