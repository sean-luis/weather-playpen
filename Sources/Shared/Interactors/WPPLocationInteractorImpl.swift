import CoreLocation

final public class LocationInteractorImpl: NSObject, LocationInteractor {
    private let manager = CLLocationManager()
    private weak var delegate: LocationManagerDelegate?
    private var currentStatus: CLAuthorizationStatus = .notDetermined
    public var currentLocation: CLLocation? { manager.location }
    
    public func requestWhenInUseAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    public func set(locationDelegate: LocationManagerDelegate) {
        delegate = locationDelegate
    }
}

extension LocationInteractorImpl: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        currentStatus = manager.authorizationStatus
        delegate?.authorizationStatusDidChange(manager, status: currentStatus)
        
        switch currentStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.didReceiveLocationUpdate(manager, currentLocation: locations.last)
    }
}

#if DEBUG
public final class PreviewLocationInteractor: LocationInteractor {
    public init() {}
    public var currentLocation: CLLocation? = CLLocation(latitude: -34.397329, longitude: 20.823780)
    public func requestWhenInUseAuthorization() {}
    public func set(locationDelegate: LocationManagerDelegate) {}
}
#endif
