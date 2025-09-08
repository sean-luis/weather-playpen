import XCTest
import FactoryKit
import Cuckoo
import CoreLocation
@testable import WeatherPlaypen

@MainActor
final class RepositoryTests: XCTestCase {
    var implementationUnderTest: WeatherRepositoryImpl!
    var mockNetworkingProvider: MockNetworkingProvider!
    var mockUserPreferences: MockUserPreferencesStore!
    let mockLocation = CLLocation(latitude: -34.397329, longitude: 20.823780)

    override func setUp() {
        super.setUp()
        mockNetworkingProvider = MockNetworkingProvider()
        mockUserPreferences = MockUserPreferencesStore()
        Container.shared.networkingProvider.register { @MainActor in self.mockNetworkingProvider as NetworkingProvider }
        Container.shared.userPreferences.register { @MainActor in self.mockUserPreferences as UserPreferencesStore }
        implementationUnderTest = WeatherRepositoryImpl()
    }

    override func tearDown() {
        mockNetworkingProvider = nil
        mockUserPreferences = nil
        implementationUnderTest = nil
        Container.shared.reset()
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(implementationUnderTest)
        XCTAssertNotNil(mockNetworkingProvider)
        XCTAssertNotNil(mockUserPreferences)
    }

    func testThatFetchWeatherCurrentIsSuccessful() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let returnType = Result<WPPCurrentDTO, Error>.self
        let mockedResult: Result<WPPCurrentDTO, Error> = .success(TestDataGenerator.mockedCurrentWeatherDTO)

        stub(mockNetworkingProvider) { mock in
            when(mock.fetchJSONModel(path: any(), parameters: any())).thenReturn(mockedResult)
        }

        stub(mockUserPreferences) { mock in
            when(mock.retrieveObject(type: any(WPPCurrentDTO.Type.self), for: any())).thenReturn(nil)
            when(mock.set(object: any(WPPCurrentDTO.self), for: any())).thenDoNothing()
        }

        do {
            _ = try await implementationUnderTest.fetchWeatherCurrent(latitude: latitude, longitude: longitude)
        } catch {
            XCTFail("Error should not be thrown")
        }

        verify(mockNetworkingProvider).fetchJSONModel(path: any(), parameters: any()).with(returnType: returnType)
        verify(mockUserPreferences).set(object: any(WPPCurrentDTO.self), for: any())
    }

    func testThatFetchWeatherCurrentFails() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let returnType = Result<WPPCurrentDTO, Error>.self
        let mockedError: Result<WPPCurrentDTO, Error> = .failure(TestDataGenerator.mockedNetworkError)

        stub(mockNetworkingProvider) { mock in
            when(mock.fetchJSONModel(path: any(), parameters: any())).thenReturn(mockedError)
        }

        stub(mockUserPreferences) { mock in
            when(mock.retrieveObject(type: any(WPPCurrentDTO.Type.self), for: any())).thenReturn(nil)
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
