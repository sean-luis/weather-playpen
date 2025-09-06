import XCTest
import FactoryKit
import Cuckoo
import CoreLocation
@testable import WeatherPlaypen

@MainActor
final class InteractorTests: XCTestCase {
    var implementationUnderTest: InteractorImpl!
    var mockRepository: MockRepository!
    let mockLocation = CLLocation(latitude: -34.397329, longitude: 20.823780)

    override func setUp() {
        super.setUp()
        mockRepository = MockRepository()
        Container.shared.repository.register { @MainActor in self.mockRepository as Repository }
        implementationUnderTest = InteractorImpl()
    }

    override func tearDown() {
        mockRepository = nil
        implementationUnderTest = nil
        Container.shared.reset()
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(implementationUnderTest)
        XCTAssertNotNil(mockRepository)
    }

    func testThatFetchWeatherCurrentIsSuccessful() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let mockedResponse = TestDataGenerator.mockedCurrentWeatherDTO

        stub(mockRepository) { mock in
            when(mock.fetchWeatherCurrent(latitude: any(), longitude: any())).thenReturn(mockedResponse)
        }

        do {
            _ = try await implementationUnderTest.fetchWeatherCurrent(latitude: latitude, longitude: longitude)
        } catch {
            XCTFail("Error should not be thrown")
        }

        verify(mockRepository).fetchWeatherCurrent(latitude: any(), longitude: any())
    }

    func testThatFetchWeatherCurrentFails() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let mockedError = TestDataGenerator.mockedNetworkError

        stub(mockRepository) { mock in
            when(mock.fetchWeatherCurrent(latitude: any(), longitude: any())).thenThrow(mockedError)
        }

        do {
            _ = try await implementationUnderTest.fetchWeatherCurrent(latitude: latitude, longitude: longitude)
            XCTFail("Error expected to be thrown")
        } catch {
            XCTAssert(error is WPPError)
        }

        verify(mockRepository).fetchWeatherCurrent(latitude: any(), longitude: any())
    }

    func testThatFetchForecastPostMiddayIsSuccessful() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let mockedResponse = TestDataGenerator.mockedPostMiddayForecastWeatherDTO

        stub(mockRepository) { mock in
            when(mock.fetchWeatherForecast(latitude: any(), longitude: any())).thenReturn(mockedResponse)
        }

        do {
            let response = try await implementationUnderTest.fetchWeatherForecast(latitude: latitude, longitude: longitude)
            XCTAssertEqual(response.forecast.count, 5)
            XCTAssertEqual(response.forecast[0].weatherType, .cloud)
            XCTAssertEqual(response.forecast[0].temperature, "25.43")
            XCTAssertEqual(response.forecast[0].dayOfWeek, "Sunday")
            XCTAssertEqual(response.forecast[1].dayOfWeek, "Monday")
            XCTAssertEqual(response.forecast[2].dayOfWeek, "Tuesday")
            XCTAssertEqual(response.forecast[3].dayOfWeek, "Wednesday")
            XCTAssertEqual(response.forecast[4].dayOfWeek, "Thursday")
        } catch {
            XCTFail("Error should not be thrown")
        }

        verify(mockRepository).fetchWeatherForecast(latitude: any(), longitude: any())
    }

    func testThatFetchForecastPostMiddayFails() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let mockedError = TestDataGenerator.mockedNetworkError

        stub(mockRepository) { mock in
            when(mock.fetchWeatherForecast(latitude: any(), longitude: any())).thenThrow(mockedError)
        }

        do {
            _ = try await implementationUnderTest.fetchWeatherForecast(latitude: latitude, longitude: longitude)
            XCTFail("Error expected to be thrown")
        } catch {
            XCTAssert(error is WPPError)
        }

        verify(mockRepository).fetchWeatherForecast(latitude: any(), longitude: any())
    }

    func testThatFetchForecastPriorMiddayIsSuccessful() async throws {
        let latitude = mockLocation.coordinate.latitude.description
        let longitude = mockLocation.coordinate.longitude.description
        let mockedResponse = TestDataGenerator.mockedPriorMiddayForecastWeatherDTO

        stub(mockRepository) { mock in
            when(mock.fetchWeatherForecast(latitude: any(), longitude: any())).thenReturn(mockedResponse)
        }

        do {
            let response = try await implementationUnderTest.fetchWeatherForecast(latitude: latitude, longitude: longitude)
            XCTAssertEqual(response.forecast.count, 5)
            XCTAssertEqual(response.forecast[0].weatherType, .cloud)
            XCTAssertEqual(response.forecast[0].temperature, "25.42")
            XCTAssertEqual(response.forecast[0].dayOfWeek, "Saturday")
            XCTAssertEqual(response.forecast[1].dayOfWeek, "Sunday")
            XCTAssertEqual(response.forecast[2].dayOfWeek, "Monday")
            XCTAssertEqual(response.forecast[3].dayOfWeek, "Tuesday")
            XCTAssertEqual(response.forecast[4].dayOfWeek, "Wednesday")
        } catch {
            XCTFail("Error should not be thrown")
        }

        verify(mockRepository).fetchWeatherForecast(latitude: any(), longitude: any())
    }
}
