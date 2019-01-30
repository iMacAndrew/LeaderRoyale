//
//  StringOrInt.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/28/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

enum StringOrInt: Decodable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .int(container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .string(container.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(StringOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Not an int or a string. Expect StringOrInt"))
            }
        }
    }
}
