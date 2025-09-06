import Foundation
import Combine
import FactoryKit
import CoreLocation

public final class LandingViewModel: NSObject, ObservableObject {
    @Injected(\.locationInteractor) private var locationInteractor
    @Published var userLocation: CLLocation?
    
    public override init() {
        super.init()
        retrieveInitialLocationIfPossible()
        setupLocationResponding()
    }

    private func retrieveInitialLocationIfPossible() {
        userLocation = locationInteractor.currentLocation
    }

    private func setupLocationResponding() {
        locationInteractor.set(locationDelegate: self)
        locationInteractor.requestWhenInUseAuthorization()
    }
}

extension LandingViewModel: LocationManagerDelegate {
    public func didReceiveLocationUpdate(_ manager: CLLocationManager, currentLocation: CLLocation?) {
        userLocation = currentLocation
    }

    public func authorizationStatusDidChange(_ manager: CLLocationManager, status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            userLocation = locationInteractor.currentLocation
        default:
            userLocation = nil
        }
    }
}
