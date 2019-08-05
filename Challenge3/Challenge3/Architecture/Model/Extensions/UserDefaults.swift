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
        case appLaunch
        case allWords
        case wordLanguage
        case useShowHint
    }
    
    func isAppAlreadyLaunchedOnce() -> Bool {
        return bool(forKey: UserDefaultsKeys.appLaunch.rawValue)
    }
    
    func setIsAppAlreadyLaunchedOnce(value: Bool) {
        set(value, forKey: UserDefaultsKeys.appLaunch.rawValue)
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
    
    func getAllWords() -> [Word] {
        if let data = value(forKey: UserDefaultsKeys.allWords.rawValue) as? Data {
            if let decodedData = try? JSONDecoder().decode([Word].self, from: data) {
                return decodedData
            }
        }
        return [Word]()
    }
    
    func setAllWords(value: [Word]) {
        set(try? JSONEncoder().encode(value), forKey: UserDefaultsKeys.allWords.rawValue)
    }
    
    func getLanguageWordsAndHints(language key: String) -> [Details] {
        if key == WordLanguages.Croatian.description {
            return getAllWords().map({ $0.hr })
        } else if key == WordLanguages.English.description {
            return getAllWords().map({ $0.en })
        }
        
        return [Details]()
    }
    
    func setLanguageWordsAndHints(language key: String, value: [Details]) {
        set(try? JSONEncoder().encode(value), forKey: key)
    }
    
}
