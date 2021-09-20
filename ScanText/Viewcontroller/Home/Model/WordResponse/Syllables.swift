//
//  Syllables.swift
//  ScanText
//
//  Created by Saravanan on 18/09/21.
//

import Foundation
struct Syllables : Codable {
    let count : Int?
    let list : [String]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        list = try values.decodeIfPresent([String].self, forKey: .list)
    }

}
