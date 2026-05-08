//
//  BusArrival+Formatting.swift
//  MuniTracker
//
//  Created by Mabel on 3/16/26.
//

import Foundation

extension BusArrival {
    
    // converts api raw time format into friendly format
    var friendlyArrivalTime: String {
        
        // formatter that understands
        let formatter = ISO8601DateFormatter()
        
        // turn raw time stamp string into Data object
        guard let arrivalDate = formatter.date(from: arrivalTime) else {
            return "Unknown"
        }
        
        // calculate minutes between now and arrival time
        // timeIntervalSinceNow is in seconds
        // Int rounds up to whole number
        let minutesUntilArrival = Int(arrivalDate.timeIntervalSinceNow / 60)
        
        // return friendly format
        if minutesUntilArrival <= 0 {
            return "Arriving Now"
        } else {
            return "\(minutesUntilArrival) min"
        }
    }
}
