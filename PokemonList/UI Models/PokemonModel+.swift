import PokemonAPI

extension PokemonModel {
    static func create(with model: [PKMPokemon]) -> [PokemonModel] {
        model.map {
            PokemonModel(name: $0.name?.capitalized ?? "pokemon_name",
                         types: createTypes(with: $0.types),
                         stats: createStats(with: $0.stats),
                         defaultImageURL: URL(string: $0.sprites?.frontDefault ?? ""),
                         sprites: createSprites(with: $0.sprites))
        }
    }
    
    fileprivate static func createTypes(with types: [PKMPokemonType]?) -> [PokemonType] {
        guard let types = types else { return [] }
        return types.map { $0.type?.name?.toPokemonType ?? .normale }
    }
    
    fileprivate static func createStats(with stats: [PKMPokemonStat]?) -> [PokemonStat] {
        guard let stats = stats else { return [] }
        return stats.map { PokemonStat(name: $0.stat?.name?.capitalized,
                                       base: $0.baseStat) }
    }
    
    fileprivate static func createSprites(with stats: PKMPokemonSprites?) -> [URL?] {
        [
            stats?.frontDefault,
            stats?.backDefault,
            stats?.backFemale,
            stats?.frontShiny,
            stats?.backShiny,
            stats?.frontShinyFemale,
            stats?.backShinyFemale
        ]
        .compactMap { $0 }
        .map(URL.init(string:))
    }
}

extension String {
    fileprivate var toPokemonType: PokemonType {
        switch self {
            case "poison": return .poison
            case "fighting": return .fighting
            case "rock": return .rock
            case "electric": return .electric
            case "ground": return .ground
            case "fairy": return .fairy
            case "ghost": return .ghost
            case "psychic": return .psychic
            case "grass": return .grass
            case "fire": return .fire
            case "water": return .water
            case "bug": return .bug
            case "normale": return .normale
            default: return .normale
        }
    }
}

