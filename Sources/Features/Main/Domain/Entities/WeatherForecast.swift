import Foundation

public struct WeatherForecast: Equatable, Hashable, Sendable {
    public static let emptyState = Self(
        forecast: [WeatherDay(weather: "", temperature: "-°", dayOfWeek: "-")]
    )
    let forecast: [WeatherDay]
}

public struct WeatherDay: Equatable, Hashable, Sendable {
    let weather: String
    let temperature: String
    let dayOfWeek: String
}

extension WeatherForecast {
    public static func transform(dto: WPPForecastDTO) -> WeatherForecast {
        Self(forecast: dto.list?.filter({
            $0.dt_txt?.contains(HTTPConstant.DictionaryValue.middayTimeStamp.rawValue) == true
        }).compactMap {
            WeatherDay(weather: $0.weather?.first?.main?.lowercased() ?? "",
                       temperature: ($0.main?.temp?.int.description ?? "-") + "°",
                       dayOfWeek: $0.dt_txt?.dayOfWeek ?? "-")
        } ?? [])
    }
}

extension WeatherDay {
    var weatherType: WeatherType {
        WeatherType(rawValue: self.weather) ?? .unknown
    }
}
