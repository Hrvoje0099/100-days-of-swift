//
//  UserDefaults.swift
//  Challenge4
//
//  Created by Hrvoje Vuković on 20/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

private let pictureKey = "picture"

public extension UserDefaults {
 
    func getPictures() -> [Picture] {
        if let data = value(forKey: pictureKey) as? Data {
            if let decodedData = try? JSONDecoder().decode([Picture].self, from: data) {
                return decodedData
            }
        }
        return [Picture]()
    }
    
    func setPicures(value: [Picture]) {
        set(try? JSONEncoder().encode(value), forKey: pictureKey)
    }
    
}
