import FactoryKit

@MainActor
public final class InteractorImpl: Sendable, Interactor {
    @Injected(\.repository) private var repository
    
    public init() {}
    
    public func fetchWeatherCurrent(latitude: String, longitude: String) async throws -> WPPCurrent {
        let response = try await repository.fetchWeatherCurrent(latitude: latitude, longitude: longitude)
        return WPPCurrent.transform(dto: response)
    }
    
    public func fetchWeatherForecast(latitude: String, longitude: String) async throws -> WPPForecast {
        let response = try await repository.fetchWeatherForecast(latitude: latitude, longitude: longitude)
        return WPPForecast.transform(dto: response)
    }
}
