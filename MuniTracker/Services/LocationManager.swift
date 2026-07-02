//
//  LocationManager.swift
//  MuniTracker
//
//  Created by Mabel on 7/1/26.
//

import CoreLocation

// MainActor for whole class because location needs to be shared
@MainActor
class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location: CLLocation? = nil
    private let manager = CLLocationManager()
    
    // Override NSObject init
    override init() {
        super.init() // NSObject setup first cause it's the parent class
        manager.delegate = self // Location manager setup
    }
    
    func fetchLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { @MainActor in
            self.location = locations.first
        }
        <#code#>
    }
    
}
