import PokemonAPI

public class PokemonServices {
    private let pokemonAPI = PokemonAPI()
    private var result: PKMPagedObject<PKMPokemon>?
    
    func getPokemons() -> ViewModel<[PKMPokemon]> {
        guard let result = result else { return fetchPokemonList() }
        return fetchPokemonList(paginationState: .continuing(result, .next))
    }

    private func fetchPokemonList(paginationState: PaginationState<PKMPokemon> = .initial(pageLimit: 20)) -> ViewModel<[PKMPokemon]> {
        ViewModel<[PKMPokemon]> { completion in
            self.pokemonAPI.pokemonService.fetchPokemonList(paginationState: paginationState) { result in
                switch result {
                    case .success(let pokemons):
                        self.result = pokemons
                        self.fetchPokemon(with: pokemons) { pokemon in
                            completion(.success(pokemon))
                        }
                    case .failure(let error): completion(.failure(error))
                }
            }
        }
    }

    private func fetchPokemon(with pokemons: PKMPagedObject<PKMPokemon>, _ completionHandler: @escaping (([PKMPokemon]) ->())) {
        guard let results = pokemons.results else { return }
        var newPokemon: [PKMPokemon] = []
        let group = DispatchGroup()
        results.forEach {
            group.enter()
            guard let pokemonName = $0 as? PKMNamedAPIResource, let name = pokemonName.name else { return }
            pokemonAPI.pokemonService.fetchPokemon(name) { result in
                switch result {
                    case .success(let pokemon): newPokemon.append(pokemon)
                    case .failure(let error): print(error)
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            completionHandler(newPokemon)
        }
    }
}
