public struct WeatherToday: Hashable, Equatable, Sendable {
    public static let emptyState = Self(
        weather: "", minimumTemp: "-°", maximumTemp: "-°", currentTemp: "-°"
    )
    let weather: String
    let minimumTemp: String
    let maximumTemp: String
    let currentTemp: String
}

extension WeatherToday {
    public static func transform(dto: WPPCurrentDTO) -> WeatherToday {
        Self(weather: dto.weather?.first?.main?.lowercased() ?? "",
             minimumTemp: (dto.main?.temp_min?.int.description ?? "-").description + "°",
             maximumTemp: (dto.main?.temp_max?.int.description ?? "-").description + "°",
             currentTemp: (dto.main?.temp?.int.description ?? "-").description + "°")
    }
}

extension WeatherToday {
    var weatherType: WeatherType {
        WeatherType(rawValue: self.weather) ?? .unknown
    }
}
