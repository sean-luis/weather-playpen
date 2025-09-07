import SwiftUICore

public enum WeatherType: Equatable, Hashable, Sendable {
    case rain, clear, cloud, unknown
    
    init?(rawValue: String) {
        switch rawValue {
        case HTTPConstant.DictionaryValue.rain.rawValue: self = .rain
        case HTTPConstant.DictionaryValue.clear.rawValue: self = .clear
        case HTTPConstant.DictionaryValue.clouds.rawValue: self = .cloud
        default: return nil
        }
    }
    
    var description: String {
        switch self {
        case .rain: Strings.weatherTypeRain
        case .clear: Strings.weatherTypeClear
        case .cloud: Strings.weatherTypeCloud
        case .unknown: "-"
        }
    }
    
    var icon: Image? {
        switch self {
        case .rain: Assets.Icons.rain.swiftUIImage
        case .clear: Assets.Icons.clear.swiftUIImage
        case .cloud: Assets.Icons.cloud.swiftUIImage
        case .unknown: nil
        }
    }
    
    var backgroundImage: Image {
        switch self {
        case .rain: Assets.Backgrounds.rainBackground.swiftUIImage
        case .clear, .unknown: Assets.Backgrounds.clearBackground.swiftUIImage
        case .cloud: Assets.Backgrounds.cloudBackground.swiftUIImage
        }
    }
    
    var color: Color {
        switch self {
        case .rain: Assets.Colors.rain.swiftUIColor
        case .clear, .unknown: Assets.Colors.clear.swiftUIColor
        case .cloud: Assets.Colors.cloud.swiftUIColor
        }
    }
}
