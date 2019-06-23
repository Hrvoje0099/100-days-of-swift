//
//  Item.swift
//  Challenge2
//
//  Created by Hrvoje Vuković on 23/06/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

struct Item: Codable, Hashable {
    var title: String = ""
    var done: Bool = false
}
