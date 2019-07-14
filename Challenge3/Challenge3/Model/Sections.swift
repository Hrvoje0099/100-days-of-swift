//
//  InfoSection.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 03/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
    var isDisclosureIndicator: Bool { get }
}

enum InfoSection: Int, CaseIterable, CustomStringConvertible {
    case Settings
    case Advanced
    
    var description: String {
        switch self {
        case .Settings: return "SETTINGS"
        case .Advanced: return "ADVANCED"
        }
    }
}

enum SettingsOptions: Int, CaseIterable, SectionType {
    case wordLanguage
    case listOfAllWords
    
    var containsSwitch: Bool { return false }
    var isDisclosureIndicator: Bool { return true }
    
    //primjer: - ako želimo da samo neki u sekciji nemaju swith tj disclosure indicator
    /*var containsSwitch: Bool {
        switch self {
        case .wordLanguage: return true
        case .listOfAllWords: return false
        }
    }
    
    var isDisclosureIndicator: Bool {
        switch self {
        case .wordLanguage: return false
        case .listOfAllWords: return true
        }
    }*/
    
    var description: String {
        switch self {
        case .wordLanguage: return "Word Language"
        case .listOfAllWords: return "List Words"
        }
    }
}

enum WordLanguages: Int, CaseIterable {
    case Croatian
    case English
    
    var description: String {
        switch self {
        case .Croatian: return "Croatian"
        case .English: return "English"
        }
    }
}

enum AdvancedOptions: Int, CaseIterable, SectionType {
    case showHint
    
    var containsSwitch: Bool { return true }
    var isDisclosureIndicator: Bool { return false }
    
    var description: String {
        switch self {
        case .showHint: return "Show Hint"
        }
    }
}
