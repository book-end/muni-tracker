//
//  ContentView.swift
//  MuniTracker
//
//  Created by Mabel on 3/9/26.
//

import SwiftUI



struct ContentView: View {
    
    @State var buses = [
        BusArrival(routeName: "14 Mission", arrivalTime: "3 min"),
        BusArrival(routeName: "49 Van Ness", arrivalTime: "7 min"),
        BusArrival(routeName: "38 Geary", arrivalTime: "12 min")
    ]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Muni!")
            Text("Powered by 511 API")
        
            ForEach(buses, id: \.id) { bus in
                BusArrivalRow(routeName: bus.routeName, arrivalTime: bus.arrivalTime)
            }
            
        }
        .padding()
        

    }
}

#Preview {
    ContentView()
}
