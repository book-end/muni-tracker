//
//  SecretsManager.swift
//  MuniTracker
//
//  Created by Mabel on 3/11/26.
//

import Foundation

enum SecretsManager {
    
    private static let keychainKey = "muni_api_key"
    
    static func getApiKey() -> String? {
        
        // check for existing api key in keychain
        if let existingKey = KeychainManager.read(key: keychainKey) {
            return existingKey
        }
        
        // get key from plist if keychain is empty, just one time
        guard let plistKey = readFromPlist() else {
            return nil
        }
        
        // inject the plist key to keychain, just one time
        let saveSucceeded = KeychainManager.save(key: keychainKey, value: plistKey)
        if !saveSucceeded {
            print("Warning: failed to save API Key to Keychain")
        }
        
        return plistKey
    }
    
    private static func readFromPlist() -> String? {
        
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
