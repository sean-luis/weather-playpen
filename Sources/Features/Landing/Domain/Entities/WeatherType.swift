import SwiftUICore

public enum WeatherType: Sendable {
    case rain, clear, cloud
    
    init?(rawValue: String) {
        switch rawValue {
        case "rain": self = .rain
        case "clear": self = .clear
        case "clouds": self = .cloud
        default: return nil
        }
    }
    
    var description: String {
        switch self {
        case .rain: "RAINY"
        case .clear: "SUNNY"
        case .cloud: "CLOUDY"
        }
    }
}
