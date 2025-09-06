import XCTest
@testable import WeatherPlaypen

final class HTTPConstantTests: XCTest {
    func testQueryParameters() {
        XCTAssertEqual(HTTPConstant.QueryParameter.latitude.rawValue, "lat")
        XCTAssertEqual(HTTPConstant.QueryParameter.longitude.rawValue, "lon")
        XCTAssertEqual(HTTPConstant.QueryParameter.apiKey.rawValue, "appid")
        XCTAssertEqual(HTTPConstant.QueryParameter.units.rawValue, "units")
    }
    
    func testDictionaryValues() {
        XCTAssertEqual(HTTPConstant.DictionaryValue.metric.rawValue, "metric")
    }
}
