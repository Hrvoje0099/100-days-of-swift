//
//  Utils.swift
//  Challenge4
//
//  Created by Hrvoje Vuković on 20/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

class Utils {
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
