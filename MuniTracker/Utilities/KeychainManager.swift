//
//  KeychainManager.swift
//  MuniTracker
//
//  Created by Mabel on 7/5/26.
//

import Foundation
import Security

// enum bc no instantiation of keychain manager
enum KeychainManager {
    
    // SAVE api key to keychain, return true/false depending if key is successfully saved
    static func save(key: String, value: String) -> Bool {
        
        // convert string into data
        guard let data = value.data(using: .utf8) else {return false}
        
        // make a dictionary item for  keychain
        let query : [String: Any]  = [
            
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecValueData as String : data
        ]
        
        // delete item from keychain if existing, btw cfdictionary is just a regulary dictionary
        SecItemDelete(<#T##query: CFDictionary##CFDictionary#>)
        
        // write item into keychain, returns a number depending on success/fail
        let status = SecItemAdd(query as CFDictionary, nil)
        
        // converts number status into bool
        return status == errSecSuccess
    }
    
    // READ key previously saved and returns it as a string decrypted by keychain
    // need original string to autheneticate against API
    static func read(key: String) -> String? {
        
        // get the dictionary item first
        let query : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String : true,
            kSecMatchLimit as String : kSecMatchLimitOne // get only one result
        ]
        
        // holds whatever dictionary item that it gets
        var result : AnyObject?
        
        // perform the lookup and write it into result
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        // two things have to be true: lookup matches and data can be turned into data
        guard status == errSecSuccess, let data = result as? Data else {return nil}
        
        // convert data into readable string
        return String(data: data, encoding: .utf8)
    }
}
