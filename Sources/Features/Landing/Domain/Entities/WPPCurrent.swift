public struct WPPCurrent: Sendable {
    let weatherType: WeatherType?
    let minimumTemp: String
    let maximumTemp: String
    let currentTemp: String
}

extension WPPCurrent {
    public static func transform(dto: WPPCurrentDTO) -> WPPCurrent {
        Self(weatherType: WeatherType(rawValue: dto.weather?.first?.main?.lowercased() ?? ""),
             minimumTemp: dto.main?.temp_min?.description ?? "-",
             maximumTemp: dto.main?.temp_min?.description ?? "-",
             currentTemp: dto.main?.temp?.description ?? "-")
    }
}
