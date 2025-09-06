import XCTest
import WeatherPlaypen
import FactoryKit
import Cuckoo
import CoreLocation

@MainActor
final class MainViewModelTests: XCTestCase {
    var implementationUnderTest: MainViewModel!
    var mockLocationInteractor: MockLocationInteractor!
    let mockedLocation = CLLocation(latitude: -34.397329, longitude: 20.823780)

    override func setUp() {
        super.setUp()
        mockLocationInteractor = MockLocationInteractor()
        Container.shared.locationInteractor.register { @MainActor in self.mockLocationInteractor as LocationInteractor }

        stub(mockLocationInteractor) { mock in
            when(mock.requestWhenInUseAuthorization()).thenDoNothing()
            when(mock.set(locationDelegate: any())).thenDoNothing()
            when(mock.currentLocation.get).thenReturn(mockedLocation)
        }

        implementationUnderTest = MainViewModel()
    }

    override func tearDown() {
        mockLocationInteractor = nil
        implementationUnderTest = nil
        Container.shared.reset()
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(implementationUnderTest)
        XCTAssertNotNil(mockLocationInteractor)
        verify(mockLocationInteractor, times(1)).currentLocation.get()
        verify(mockLocationInteractor, times(1)).requestWhenInUseAuthorization()
        verify(mockLocationInteractor, times(1)).set(locationDelegate: any())
    }
}
