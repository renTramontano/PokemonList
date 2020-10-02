import UIKit

final class Navigator {
    static let shared = Navigator()
    var services = PokemonServices()
    
    private init() {}
    
    enum Segue: Hashable {
        case home
        case detail(PokemonModel)
    }
    
    private func create(_ segue: Segue) -> UIViewController {
        switch segue {
            case .home:
                return PokedexViewController.create(with: self)
            case .detail(let model):
                return PokemonDetailViewController.create(with: self, model: model)
        }
    }
    
    func setRootViewController(with window: UIWindow?) {
        guard let window = window else { return }
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let navigationController = UINavigationController()
        navigationController.setViewControllers([Navigator.shared.create(.home)], animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func present(_ segue: Segue, from controller: UIViewController) {
        controller.present(create(segue), animated: true)
    }
}
