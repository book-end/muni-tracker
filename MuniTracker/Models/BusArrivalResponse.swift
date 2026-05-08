//
//  BusArrivalResponse.swift
//  MuniTracker
//
//  Created by Mabel on 3/12/26.
//

import Foundation

struct BusArrivalResponse: Codable {
    let serviceDelivery: ServiceDelivery
    
    enum CodingKeys: String, CodingKey {
        case serviceDelivery = "ServiceDelivery"
    }
}

struct ServiceDelivery: Codable {
    let stopMonitoringDelivery: StopMonitoringDelivery
    
    enum CodingKeys: String, CodingKey {
        case stopMonitoringDelivery = "StopMonitoringDelivery"
    }
}

struct StopMonitoringDelivery: Codable {
    let monitoredStopVisit: [MonitoredStopVisit]
    
    enum CodingKeys: String, CodingKey {
        case monitoredStopVisit = "MonitoredStopVisit"
    }
}

struct MonitoredStopVisit: Codable {
    let monitoredVehicleJourney: MonitoredVehicleJourney
    
    enum CodingKeys: String, CodingKey {
        case monitoredVehicleJourney = "MonitoredVehicleJourney"
    }
}

struct MonitoredVehicleJourney: Codable {
    let PublishedLineName: String
    let MonitoredCall: MonitoredCall
}

struct MonitoredCall: Codable {
    let ExpectedArrivalTime: String?
    
    enum CodingKeys: String, CodingKey {
        case ExpectedArrivalTime = "ExpectedArrivalTime"
    }
}
