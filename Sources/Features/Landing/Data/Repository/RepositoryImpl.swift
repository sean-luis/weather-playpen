import FactoryKit

@MainActor
public final class RepositoryImpl: Sendable, Repository {
    @Injected(\.networkingProvider) private var networkingProvider
    
    public init() {}
    
    public func fetchWeatherCurrent(latitude: String, longitude: String) async throws -> WPPCurrentDTO {
        let parameters = [
            HTTPConstant.QueryParameter.latitude.rawValue: latitude,
            HTTPConstant.QueryParameter.longitude.rawValue: longitude,
            HTTPConstant.QueryParameter.units.rawValue: HTTPConstant.DictionaryValue.metric.rawValue,
            HTTPConstant.QueryParameter.apiKey.rawValue: ""
        ]
        
        let result: Result<WPPCurrentDTO, Error> =
            try await networkingProvider.fetchJSONModel(path: Endpoints.current.rawValue, parameters: parameters)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    @MainActor
    public func fetchWeatherForecast(latitude: String, longitude: String) async throws -> WPPForecastDTO {
        let parameters = [
            HTTPConstant.QueryParameter.latitude.rawValue: latitude,
            HTTPConstant.QueryParameter.longitude.rawValue: longitude,
            HTTPConstant.QueryParameter.units.rawValue: HTTPConstant.DictionaryValue.metric.rawValue,
            HTTPConstant.QueryParameter.apiKey.rawValue: ""
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
