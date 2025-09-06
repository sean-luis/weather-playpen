import Foundation
import Combine
import FactoryKit
import CoreLocation
import OSLog

@MainActor
public final class LandingViewModel: NSObject, ObservableObject {
    @Injected(\.locationInteractor) private var locationInteractor
    @Injected(\.repository) private var repository
    @Published var userLocation: CLLocation?
    
    public override init() {
        super.init()
        retrieveInitialLocationIfPossible()
        setupLocationResponding()
    }
    
    public func fetchWeatherToday() async {
        guard let userLocation else { return }
        
        do {
            try await repository.fetchWeatherCurrent(latitude: userLocation.coordinate.latitude.description,
                                                     longitude: userLocation.coordinate.longitude.description)
        } catch {
            OSLog.network.debug("Failed to fetch todays weather: \(String(describing: error))")
        }
    }
    
    public func fetchWeatherForecast() async {
        guard let userLocation else { return }
        
        do {
            try await repository.fetchWeatherForecast(latitude: userLocation.coordinate.latitude.description,
                                                      longitude: userLocation.coordinate.longitude.description)
        } catch {
            OSLog.network.debug("Failed to fetch forecast: \(String(describing: error))")
        }
    }

    private func retrieveInitialLocationIfPossible() {
        userLocation = locationInteractor.currentLocation
    }

    private func setupLocationResponding() {
        locationInteractor.set(locationDelegate: self)
        locationInteractor.requestWhenInUseAuthorization()
    }
}

extension LandingViewModel: @preconcurrency LocationManagerDelegate {
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
