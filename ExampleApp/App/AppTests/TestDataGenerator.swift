import WeatherPlaypen

final class TestDataGenerator {
    static var mockedNetworkError: WPPError {
        WPPError.defaultWPPError(error: .init(domain: "tests", code: 500))
    }

    // MARK: Entities

    static var mockedCurrentWeather: WPPCurrent {
        WPPCurrent.transform(dto: mockedCurrentWeatherDTO)
    }

    static var mockedPostMiddayForecastWeather: WPPForecast {
        WPPForecast.transform(dto: mockedPostMiddayForecastWeatherDTO)
    }

    static var mockedPriorMiddayForecastWeather: WPPForecast {
        WPPForecast.transform(dto: mockedPriorMiddayForecastWeatherDTO)
    }

    // MARK: DTOs

    static var mockedCurrentWeatherDTO: WPPCurrentDTO {
        TestHelpers.decodeJsonObject(ofType: WPPCurrentDTO.self,
                                     from: "weather-current",
                                     in: TestHelpers.bundle)!
    }

    static var mockedPostMiddayForecastWeatherDTO: WPPForecastDTO {
        TestHelpers.decodeJsonObject(ofType: WPPForecastDTO.self,
                                     from: "weather-forecast-post-midday",
                                     in: TestHelpers.bundle)!
    }

    static var mockedPriorMiddayForecastWeatherDTO: WPPForecastDTO {
        TestHelpers.decodeJsonObject(ofType: WPPForecastDTO.self,
                                     from: "weather-forecast-prior-midday",
                                     in: TestHelpers.bundle)!
    }
}
