//
//  BusArrivalViewModel.swift
//  MuniTracker
//
//  Created by Mabel on 3/11/26.
//

import Foundation

class BusArrivalViewModel: ObservableObject {
    
    // @Published is ViewModel equivalent of @State except it's for data that lives outside the View and needs to be shared
    // BAsically ViewModel owns that data instead of ContentView
    @Published var buses: [BusArrival] = []
    @Published var loadingState: LoadingState = .loading
    
    // Function to fetch real bus data
    // Note: async means to let everything else keep running while this func runs
    func fetchBusArrivals() async {
        let apiKey = SecretsManager.apiKey()
        
        // Build url string with api key
        let urlString = "http://api.511.org/transit/StopMonitoring?api_key=\(apiKey)&agency=[operatorID]"
        
        // Convert url string into url object
        guard let urlObject = URL(string: urlString) else {
            loadingState = .error("Invalid URL")
            return
        }
    }
}
