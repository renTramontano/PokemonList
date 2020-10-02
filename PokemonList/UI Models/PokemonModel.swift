import UIKit

struct PokemonModel: Hashable {
    let name: String
    let types: [PokemonType]
    let stats: [PokemonStat]
    let defaultImageURL: URL?
    let sprites: [URL?]
}

public enum PokemonType {
    case poison
    case fighting
    case rock
    case electric
    case ground
    case fairy
    case ghost
    case psychic
    case grass
    case fire
    case water
    case bug
    case ice
    case flying
    case dragon
    case dark
    case steel
    case normale

    var name: String {
        switch self {
            case .poison: return "Poison"
            case .fighting: return "Fighting"
            case .rock: return "Rock"
            case .electric: return "Electric"
            case .ground: return "Ground"
            case .fairy: return "Fairy"
            case .ghost: return "Ghost"
            case .psychic: return "Psychic"
            case .grass: return "Grass"
            case .fire: return "Fire"
            case .water: return "Water"
            case .bug: return "Bug"
            case .ice: return "Ice"
            case .flying: return "Flying"
            case .dragon: return "Dragon"
            case .dark: return "Dark"
            case .steel: return "Steel"
            case .normale: return "Normal"
        }
    }

    var color: UIColor {
        switch self {
            case .poison: return UIColor(hex: 0xD170D1)
            case .fighting: return UIColor(hex: 0xE1615B)
            case .rock: return UIColor(hex: 0xB6A136)
            case .electric: return UIColor(hex: 0xFFD86F)
            case .ground: return UIColor(hex: 0xBFA96E)
            case .fairy: return UIColor(hex: 0xEBA8C9)
            case .ghost: return UIColor(hex: 0x5D4D71)
            case .psychic: return UIColor(hex: 0xBB5F7A)
            case .grass: return UIColor(hex: 0x48D0B0)
            case .fire: return UIColor(hex: 0xFB6C6C)
            case .water: return UIColor(hex: 0x76BDFE)
            case .bug: return UIColor(hex: 0xCBDC4E)
            case .ice: return UIColor(hex: 0xB5ECEA)
            case .flying: return UIColor(hex: 0xD0C1F9)
            case .dragon: return UIColor(hex: 0x9367FE)
            case .dark: return UIColor(hex: 0x2F3D48)
            case .steel: return UIColor(hex: 0xD3D3E7)
            case .normale: return UIColor(hex: 0xD3BFB4)
        }
    }
}

struct PokemonStat: Hashable {
    let name: String?
    let base: Int?
}
