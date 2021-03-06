//
//  NetworkParameterEncoding.swift
//
//  Created by Eric Dobyns & Luis Garcia.
//  Copyright © 2017 Eric Dobyns & Luis Garcia. All rights reserved.
//

import Foundation

// MARK: - Parameter Encoding Type
public enum NetworkParameterEncoding {
    case json
    case url
    
    public func contentType() -> String {
        switch self {
        case .json:
            return "application/json"
        case .url:
            return "application/x-www-form-urlencoded"
        }
    }
}


// MARK: - Dictionary Extension
//  Adds multiple parameter encoding types to Dictionary
extension Dictionary {
    
    // Convert dictionary to query variables (URL Encoded String)
    var urlEncodedString: String? {
        
        var encodedArray = [String]()
        
        for (key, value) in self {
            
            guard let key = key as? NSString else {
                assertionFailure("Parsing error")
                return nil
            }
            
            guard let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                assertionFailure("Parsing error")
                return nil
            }
            
            guard let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                assertionFailure("Parsing error")
                return nil
            }
            
            encodedArray.append("\(encodedKey)=\(encodedValue)")
        }
        return encodedArray.joined(separator: "&")
    }
    
    // Convert dictionary to json
    var jsonEncodedData: Data? {
        
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
