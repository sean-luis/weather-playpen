import XCTest
import FactoryKit
import Cuckoo
import CoreLocation
@testable import WeatherPlaypen

@MainActor
final class RepositoryTests: XCTestCase {
    var implementationUnderTest: RepositoryImpl!
    var mockNetworkingProvider: MockNetworkingProvider!
    let mockLocation = CLLocation(latitude: -34.397329, longitude: 20.823780)

    override func setUp() {
        super.setUp()
        mockNetworkingProvider = MockNetworkingProvider()
        Container.shared.networkingProvider.register { @MainActor in self.mockNetworkingProvider as NetworkingProvider }
        implementationUnderTest = RepositoryImpl()
    }

    override func tearDown() {
        mockNetworkingProvider = nil
        implementationUnderTest = nil
        Container.shared.reset()
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(implementationUnderTest)
        XCTAssertNotNil(mockNetworkingProvider)
    }

    func testThatFetchWeatherCurrentIsSuccessful() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let returnType = Result<WPPCurrentDTO, Error>.self
        let mockedResult: Result<WPPCurrentDTO, Error> = .success(TestDataGenerator.mockedCurrentWeatherDTO)

        stub(mockNetworkingProvider) { mock in
            when(mock.fetchJSONModel(path: any(), parameters: any())).thenReturn(mockedResult)
        }

        do {
            _ = try await implementationUnderTest.fetchWeatherCurrent(latitude: latitude, longitude: longitude)
        } catch {
            XCTFail("Error should not be thrown")
        }

        verify(mockNetworkingProvider).fetchJSONModel(path: any(), parameters: any()).with(returnType: returnType)
    }

    func testThatFetchWeatherCurrentFails() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let returnType = Result<WPPCurrentDTO, Error>.self
        let mockedError: Result<WPPCurrentDTO, Error> = .failure(TestDataGenerator.mockedNetworkError)

        stub(mockNetworkingProvider) { mock in
            when(mock.fetchJSONModel(path: any(), parameters: any())).thenReturn(mockedError)
        }

        do {
            _ = try await implementationUnderTest.fetchWeatherCurrent(latitude: latitude, longitude: longitude)
            XCTFail("Error expected to be thrown")
        } catch {
            XCTAssert(error is WPPError)
        }

        verify(mockNetworkingProvider).fetchJSONModel(path: any(), parameters: any()).with(returnType: returnType)
    }
    
    func testThatFetchForecastIsSuccessful() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let returnType = Result<WPPForecastDTO, Error>.self
        let mockedResult: Result<WPPForecastDTO, Error> = .success(TestDataGenerator.mockedPostMiddayForecastWeatherDTO)

        stub(mockNetworkingProvider) { mock in
            when(mock.fetchJSONModel(path: any(), parameters: any())).thenReturn(mockedResult)
        }

        do {
            _ = try await implementationUnderTest.fetchWeatherForecast(latitude: latitude, longitude: longitude)
        } catch {
            XCTFail("Error should not be thrown")
        }

        verify(mockNetworkingProvider).fetchJSONModel(path: any(), parameters: any()).with(returnType: returnType)
    }
    
    func testThatFetchForecastFails() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let returnType = Result<WPPForecastDTO, Error>.self
        let mockedError: Result<WPPForecastDTO, Error> = .failure(TestDataGenerator.mockedNetworkError)

        stub(mockNetworkingProvider) { mock in
            when(mock.fetchJSONModel(path: any(), parameters: any())).thenReturn(mockedError)
        }

        do {
            _ = try await implementationUnderTest.fetchWeatherForecast(latitude: latitude, longitude: longitude)
            XCTFail("Error expected to be thrown")
        } catch {
            XCTAssert(error is WPPError)
        }

        verify(mockNetworkingProvider).fetchJSONModel(path: any(), parameters: any()).with(returnType: returnType)
    }
}
