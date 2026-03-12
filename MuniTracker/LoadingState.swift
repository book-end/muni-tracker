//
//  LoadingState.swift
//  MuniTracker
//
//  Created by Mabel on 3/11/26.
//

import Foundation

enum LoadingState: Equatable {
    case loading
    case success
    case error(String)
}
