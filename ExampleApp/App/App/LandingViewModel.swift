import Foundation
import Combine
import FactoryKit
import WeatherPlaypen
import CoreLocation

final class LandingViewModel: NSObject, ObservableObject {
    @Injected(\.locationInteractor) private var locationInteractor
    @Published var userLocation: CLLocation?

    func retrieveInitialLocationIfPossible() {
        userLocation = locationInteractor.currentLocation
    }

    func setupLocationResponding() {
        locationInteractor.add(locationDelegate: self)
        locationInteractor.requestWhenInUseAuthorization()
    }
}

extension LandingViewModel: LocationManagerDelegate {
    func didReceiveLocationUpdate(_ manager: CLLocationManager, currentLocation: CLLocation?) {
        userLocation = currentLocation
    }

    func authorizationStatusDidChange(_ manager: CLLocationManager, status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            userLocation = locationInteractor.currentLocation
        default:
            userLocation = nil
        }
    }
}
