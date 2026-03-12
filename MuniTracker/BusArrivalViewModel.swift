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
}
