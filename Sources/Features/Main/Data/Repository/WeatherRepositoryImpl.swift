import FactoryKit

@MainActor
public final class WeatherRepositoryImpl: Sendable, WeatherRepository {
    @Injected(\.networkingProvider) private var networkingProvider
    @Injected(\.userPreferences) private var userPreferences
    
    public init() {}
    
    public func fetchWeatherCurrent(latitude: String, longitude: String) async throws -> WPPCurrentDTO {
        let key = String(describing: WPPCurrentDTO.self)
        
        if let cachedResponse = userPreferences.retrieveObject(type: WPPCurrentDTO.self, for: key) {
            return cachedResponse
        }
        
        let parameters = [
            HTTPConstant.QueryParameter.latitude.rawValue: latitude,
            HTTPConstant.QueryParameter.longitude.rawValue: longitude,
            HTTPConstant.QueryParameter.units.rawValue: HTTPConstant.DictionaryValue.metric.rawValue,
            HTTPConstant.QueryParameter.apiKey.rawValue: "API_KEY"
        ]
        
        let result: Result<WPPCurrentDTO, Error> =
            try await networkingProvider.fetchJSONModel(path: Endpoints.current.rawValue, parameters: parameters)
        
        switch result {
        case .success(let response):
            userPreferences.set(object: response, for: key)
            return response
        case .failure(let error):
            throw error
        }
    }
    
    public func fetchWeatherForecast(latitude: String, longitude: String) async throws -> WPPForecastDTO {

        let parameters = [
            HTTPConstant.QueryParameter.latitude.rawValue: latitude,
            HTTPConstant.QueryParameter.longitude.rawValue: longitude,
            HTTPConstant.QueryParameter.units.rawValue: HTTPConstant.DictionaryValue.metric.rawValue,
            HTTPConstant.QueryParameter.apiKey.rawValue: "API_KEY"
        ]
        
        let result: Result<WPPForecastDTO, Error> =
            try await networkingProvider.fetchJSONModel(path: Endpoints.forecast.rawValue, parameters: parameters)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
