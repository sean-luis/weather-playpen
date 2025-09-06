import Foundation

public struct WPPForecast: Sendable {
    let forecast: [WPPForecastDay]
}

public struct WPPForecastDay: Sendable {
    let weatherType: WeatherType?
    let temperature: String
    let dayOfWeek: String
}

extension WPPForecast {
    public static func transform(dto: WPPForecastDTO) -> WPPForecast {
        Self(forecast: dto.list?.filter({
            $0.dt_txt?.contains(HTTPConstant.DictionaryValue.middayTimeStamp.rawValue) == true
        }).compactMap {
            WPPForecastDay(weatherType: WeatherType(rawValue: $0.weather?.first?.main?.lowercased() ?? ""),
                           temperature: $0.main?.temp?.description ?? "-",
                           dayOfWeek: $0.dt_txt?.dayOfWeek ?? "-")
        } ?? [])
    }
}
