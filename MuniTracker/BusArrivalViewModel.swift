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
        print("Token being used: '\(apiKey)'")
        
        // Build url string with api key
        let urlString = "https://api.511.org/transit/StopMonitoring?api_key=\(apiKey)&agency=SF&stopCode=15184&format=json"
        
        // Convert url string into a proper url object
        guard let urlObject = URL(string: urlString) else {
            loadingState = .error("Invalid URL")
            return
        }
        
        // Network request
        do {
            // Make a https request, returns raw response data and metadata
            // await: pause this function and wait for data from URLSession, but everything else keeps running
            let (data, _) = try await URLSession.shared.data(from: urlObject)
            // Conver raw response into readable String
            print(String(data: data, encoding: .utf8) ?? "No data")
        } catch {
            loadingState = .error(error.localizedDescription)
        }
    }
}
