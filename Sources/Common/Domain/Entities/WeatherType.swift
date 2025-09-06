import SwiftUICore

public enum WeatherType: Sendable {
    case rain, clear, cloud
    
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
        }
    }
    
    var icon: Image {
        switch self {
        case .rain: Assets.Icons.rain.swiftUIImage
        case .clear: Assets.Icons.clear.swiftUIImage
        case .cloud: Assets.Icons.cloud.swiftUIImage
        }
    }
    
    var background: Image {
        switch self {
        case .rain: Assets.Backgrounds.rain.swiftUIImage
        case .clear: Assets.Backgrounds.clear.swiftUIImage
        case .cloud: Assets.Backgrounds.cloud.swiftUIImage
        }
    }
}
