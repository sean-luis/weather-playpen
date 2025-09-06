import WeatherPlaypen

final class TestDataGenerator {
    static var mockedNetworkError: WPPError {
        WPPError.defaultWPPError(error: .init(domain: "tests", code: 500))
    }
    
    static var mockedCurrentWeatherDTO: WPPCurrentDTO {
        WPPCurrentDTO()
    }
    
    static var mockedForecastWeatherDTO: WPPForecastDTO {
        WPPForecastDTO()
    }
}
