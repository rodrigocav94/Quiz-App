//
//  UserDefaultsManager.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 29/09/24.
//

import Foundation

enum UserDefaultsManager {
    static private let userDefaults = UserDefaults.standard
    
    static var lastKnownProfile: Profile? {
        get {
            UserDefaults.getData(forKey: Constants.UserDefaultsKey.lastKnownProfile.rawValue, elseReturn: nil as Profile?)
        }
        set {
            UserDefaults.setAsData(newValue, forKey: Constants.UserDefaultsKey.lastKnownProfile.rawValue)
        }
    }
}
