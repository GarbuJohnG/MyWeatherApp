//
//  LocaionManager.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    fileprivate var locationManager: CLLocationManager!
    
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    var prevrefreshlatitude = CLLocation(latitude: 0.0, longitude: 0.0)
    
    func initializeLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latitude = locValue.latitude
        longitude = locValue.longitude
        if latitude != 0.0 && longitude != 0.0 {
            let firsLocation = prevrefreshlatitude
            let secondLocation = CLLocation(latitude: latitude, longitude: longitude)
            let distance = firsLocation.distance(from: secondLocation)
            if distance > 500 {
                prevrefreshlatitude = CLLocation(latitude: latitude, longitude: longitude)
                notifyLocationFound()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if locationManager.authorizationStatus != .notDetermined {
            // Post failure error only when authorization status is determined
            NotificationCenter.default.post(name: Notification.Name(LOC_ERROR), object: nil)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied,.restricted:
            NotificationCenter.default.post(name: Notification.Name(LOC_ERROR), object: nil)
        default:
            return
        }
    }
    
    private func notifyLocationFound() {
        NotificationCenter.default.post(name: Notification.Name(LOC_FOUND), object: nil)
    }
    
    
}
