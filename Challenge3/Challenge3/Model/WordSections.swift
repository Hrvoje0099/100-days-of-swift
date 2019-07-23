//
//  WordSections.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 21/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

protocol WordType: CustomStringConvertible {
    var containsTextfield: Bool { get }
    var placeholder: String { get }
}

enum NewWord: Int, CaseIterable, WordType {
    case word
    case hint
    
    var containsTextfield: Bool { return true }
    
    var placeholder: String {
        switch self {
        case .word: return "Enter word"
        case .hint: return "Enter hint"
        }
    }
    
    var description: String {
        switch self {
        case .word: return "Word"
        case .hint: return "Hint"
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
