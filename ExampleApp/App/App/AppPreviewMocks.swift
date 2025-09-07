import WeatherPlaypen
import CoreLocation

#if DEBUG
final class PreviewInteractor: Sendable, WeatherInteractor {
    public func fetchWeatherCurrent(latitude: String, longitude: String) async throws -> WeatherToday {
        TestDataGenerator.mockedCurrentWeather
    }

    public func fetchWeatherForecast(latitude: String, longitude: String) async throws -> WeatherForecast {
        TestDataGenerator.mockedPostMiddayForecastWeather
    }
}

final class PreviewLocationInteractor: LocationInteractor {
    public init() {}
    public var currentLocation: CLLocation? = CLLocation(latitude: -34.397329, longitude: 20.823780)
    public func requestWhenInUseAuthorization() {}
    public func set(locationDelegate: LocationManagerDelegate) {}
}
#endif
