import Foundation
import OSLog

@MainActor
final class NetworkingProviderImpl: Sendable, NetworkingProvider {
    private let defaultError = NSError(domain: "com.app.weather-playpen", code: 500, userInfo: nil)
    
    func fetchJSONModel<Model: Codable & Sendable>(path: String, parameters: [String: String]) async throws -> Result<Model, Error> {
        var urlComponents = URLComponents(string: path)
        
        urlComponents?.queryItems = parameters.map({ key, value in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        OSLog.network.debug("Performing network request for \(String(describing: url))")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw WPPError.statusCodeFailure(statusCode: -1)
        }
        
        guard (200...299).contains(statusCode) else {
            throw WPPError.statusCodeFailure(statusCode: statusCode)
        }
        
        let decodedResponse = try JSONDecoder().decode(Model.self, from: data)
        
        OSLog.network.debug("Successfully retrieved response:\n\n\(String(describing: decodedResponse))")
        return .success(decodedResponse)
    }
}
