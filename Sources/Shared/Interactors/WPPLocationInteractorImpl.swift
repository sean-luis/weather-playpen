import CoreLocation

final public class LocationInteractorImpl: NSObject, LocationInteractor {
    private let manager = CLLocationManager()
    private weak var delegate: LocationManagerDelegate?
    private var currentStatus: CLAuthorizationStatus = .notDetermined
    public var currentLocation: CLLocation? { manager.location }
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
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
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        
    }
}
