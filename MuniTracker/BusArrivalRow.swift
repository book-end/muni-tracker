//
//  BusArrivalRow.swift
//  MuniTracker
//
//  Created by Mabel on 3/9/26.
//

import SwiftUI

struct BusArrivalRow: View {
    
    var routeName: String
    var arrivalTime: String
    
    var body: some View {
        HStack {
            Text(routeName)
            Spacer()
            Text(arrivalTime)
        }
        
        .padding()
    }
    
}

#Preview {
    BusArrivalRow(routeName: "14 Mission", arrivalTime: "3 min")
}



