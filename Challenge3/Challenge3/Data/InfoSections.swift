//
//  InfoSection.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 03/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

protocol InfoSectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
    var isDisclosureIndicator: Bool { get }
}

enum InfoSection: Int, CaseIterable {
    case settings
    case advanced
    
    var description: String {
        switch self {
        case .settings: return "SETTINGS"
        case .advanced: return "ADVANCED"
        }
    }
}

enum SettingsOptions: Int, CaseIterable, InfoSectionType {
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

enum AdvancedOptions: Int, CaseIterable, InfoSectionType {
    case showHint
    
    var containsSwitch: Bool { return true }
    var isDisclosureIndicator: Bool { return false }
    
    var description: String {
        switch self {
        case .showHint: return "Show Hint"
        }
    }
}
