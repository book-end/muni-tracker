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
    @MainActor
    func fetchBusArrivals() async {
        let apiKey = SecretsManager.apiKey()
        
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
            
            // Convert raw response into readable String
            // print(String(data: data, encoding: .utf8) ?? "No data")
            // Replaced with below, the decoder
            // use BusArrivalReponse (the Json codable structs) as blueprint formed from data (the raw Json data)
            let decoder = JSONDecoder()
            let response = try decoder.decode(BusArrivalResponse.self, from: data)
            
            // Dig through the response to find arrival times
            let visits = response.serviceDelivery.stopMonitoringDelivery.monitoredStopVisit
            
            // Convert the map of visits into bus arrival object
            let busArrivals = visits.map { visit in
                BusArrival(
                    routeName: visit.monitoredVehicleJourney.PublishedLineName,
                    arrivalTime: visit.monitoredVehicleJourney.MonitoredCall.ExpectedArrivalTime ?? "Unknown")
            
            }
            
            // arrival is a temp variable
                .filter { arrival in arrival.arrivalTime != "Unknown"}
            

            
            // Update the published properties (the ones in this function, see above)
            self.buses = busArrivals
            self.loadingState = .success
            
            
        } catch {
            
            print("Decoding error: \(error)")
            loadingState = .error(error.localizedDescription)
        }
    }
}
