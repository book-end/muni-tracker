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
    
    // loadingState holds value that starts out as .loading case
    @State var loadingState: LoadingState = .loading
    
    var body: some View {
        VStack {
            if loadingState == .loading {
                ProgressView("Loading bus times...")
            } else if loadingState == .success {
                ForEach(buses, id: \.id) { bus in
                    BusArrivalRow(routeName: bus.routeName, arrivalTime: bus.arrivalTime)
                }
            } else {
                Text("Something went wrong!")
            }
            
        }
        .padding()
        

    }
}

#Preview {
    ContentView()
}
