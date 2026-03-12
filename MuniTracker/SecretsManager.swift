//
//  SecretsManager.swift
//  MuniTracker
//
//  Created by Mabel on 3/11/26.
//

import Foundation

struct SecretsManager {
    static func apiKey() -> String {
        
        // Find Secrets.plist file in app bundle and save its path
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
            // Load file's contents into dictionary
            let dict = NSDictionary(contentsOfFile: path),
              
            // Key is stored in key with API_KEY as identifier
            let key = dict["API_KEY"] as? String else {
                
                fatalError("API key not found in Secrets.plist")
        }
                  
        return key
        
    }
}
