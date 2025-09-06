import CoreLocation

public protocol LocationManagerDelegate: NSObjectProtocol, CLLocationManagerDelegate {
    func didReceiveLocationUpdate(_ manager: CLLocationManager, currentLocation: CLLocation?)
    func authorizationStatusDidChange(_ manager: CLLocationManager, status: CLAuthorizationStatus)
}

public protocol LocationInteractor {
    var currentLocation: CLLocation? { get }
    func requestWhenInUseAuthorization()
    func set(locationDelegate: LocationManagerDelegate)
}
