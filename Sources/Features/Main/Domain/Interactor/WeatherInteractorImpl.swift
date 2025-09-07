import FactoryKit

@MainActor
public final class WeatherInteractorImpl: Sendable, WeatherInteractor {
    @Injected(\.repository) private var repository
    
    public init() {}
    
    public func fetchWeatherCurrent(latitude: String, longitude: String) async throws -> WeatherToday {
        let response = try await repository.fetchWeatherCurrent(latitude: latitude, longitude: longitude)
        return WeatherToday.transform(dto: response)
    }
    
    public func fetchWeatherForecast(latitude: String, longitude: String) async throws -> WeatherForecast {
        let response = try await repository.fetchWeatherForecast(latitude: latitude, longitude: longitude)
        return WeatherForecast.transform(dto: response)
    }
}
