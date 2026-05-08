//
//  ContentView.swift
//  MuniTracker
//
//  Created by Mabel on 3/9/26.
//

import SwiftUI



struct ContentView: View {
    
    
    @StateObject var viewModel = BusArrivalViewModel()
    
    var body: some View {
        Group {
            if viewModel.loadingState == .loading {
                ProgressView("Loading bus times...")
            } else if viewModel.loadingState == .success {
                ForEach(viewModel.buses, id: \.id) { bus in
                    BusArrivalRow(routeName: bus.routeName, arrivalTime: bus.friendlyArrivalTime)
                }
            } else {
                Text("Something went wrong!")
            }
            
        }
        
        .task {
            // Runs when ContentView appears on screen
            // await added because fetchBusArrivals is async func
            await viewModel.fetchBusArrivals()
        }
        .padding()
        

    }
}

#Preview {
    ContentView()
}
