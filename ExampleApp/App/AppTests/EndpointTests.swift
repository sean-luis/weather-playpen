import XCTest
@testable import WeatherPlaypen

final class EndpointTests: XCTest {
    func testEndpoints() {
        XCTAssertEqual(Endpoints.current.rawValue, "https://api.openweathermap.org/data/2.5/weather")
        XCTAssertEqual(Endpoints.forecast.rawValue, "https://api.openweathermap.org/data/2.5/forecast")
    }
}
