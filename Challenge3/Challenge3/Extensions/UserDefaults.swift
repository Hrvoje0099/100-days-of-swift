//
//  UserDefaults+Key.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 04/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case wordLanguage
        case useShowHint
    }
    
    func getWordLanguage() -> String {
        return string(forKey: UserDefaultsKeys.wordLanguage.rawValue) ?? WordLanguages.Croatian.description
    }
    
    func setWordLanguage(value: String) {
        set(value, forKey: UserDefaultsKeys.wordLanguage.rawValue)
    }
    
    func useShowHint() -> Bool {
        return bool(forKey: UserDefaultsKeys.useShowHint.rawValue)
    }
    
    func setUseShowHint(value: Bool) {
        set(value, forKey: UserDefaultsKeys.useShowHint.rawValue)
    }
    
    func getLanguageWordsAndHints(language key: String) -> [Details] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return [Details]() }
        return try! PropertyListDecoder().decode(Array<Details>.self, from: data)
    }
    
    func setLanguageWordsAndHints(language key: String, value: [Details]) {
        set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    
}

