import CoreLocation

// MARK: Domain

public protocol WeatherInteractor: Sendable {
    func fetchWeatherCurrent(latitude: String, longitude: String) async throws -> WeatherToday
    func fetchWeatherForecast(latitude: String, longitude: String) async throws -> WeatherForecast
}

// MARK: Data

public protocol WeatherRepository: Sendable {
    func fetchWeatherCurrent(latitude: String, longitude: String) async throws -> WPPCurrentDTO
    func fetchWeatherForecast(latitude: String, longitude: String) async throws -> WPPForecastDTO
}

public protocol NetworkingProvider: Sendable {
    func fetchJSONModel<Model: Codable & Sendable>(path: String, parameters: [String: String]) async throws -> Result<Model, Error>
}

// MARK: Utilities

public protocol LocationManagerDelegate: NSObjectProtocol, CLLocationManagerDelegate {
    func didReceiveLocationUpdate(_ manager: CLLocationManager, currentLocation: CLLocation?)
    func authorizationStatusDidChange(_ manager: CLLocationManager, status: CLAuthorizationStatus)
}

public protocol LocationInteractor {
    var currentLocation: CLLocation? { get }
    func requestWhenInUseAuthorization()
    func set(locationDelegate: LocationManagerDelegate)
}
