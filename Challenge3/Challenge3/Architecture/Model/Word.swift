//
//  Word.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 07/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

public struct Word: Codable {
    var hr: Details
    var en: Details
}

public struct Details: Codable {
    var word: String
    var hint: String
}
