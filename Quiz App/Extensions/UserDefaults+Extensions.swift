//
//  UserDefaults+Extensions.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 29/09/24.
//

import Foundation

extension UserDefaults {
    // Shortcut for getting Data from an UserDefaults key and converting it
    static func getData<T: Decodable>(forKey key: String, elseReturn: T) -> T {
        if let retrievedData = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode(T.self, from: retrievedData) {
                return decodedData
            }
        }
        return elseReturn
    }
    
    // Shortcut for converting an object to Data and storing it to an UserDefaults key
    static func setAsData<T: Encodable>(_ object: T, forKey key: String) {
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(object) {
            UserDefaults.standard.setValue(data, forKey: key)
        }
    }
}
