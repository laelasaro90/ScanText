//
//  TwitterResponse.swift
//  ScanText
//
//  Created by Saravanan on 20/09/21.
//

import Foundation
struct TwiiterResponse : Codable {
    let success : Bool?
    let rows : [Rows]?
    let cached : Bool?
    let cachekey : String?
    let checkedOrphan : Bool?
    let offset : Int?
    let count : Int?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case rows = "rows"
        case cached = "cached"
        case cachekey = "cachekey"
        case checkedOrphan = "checkedOrphan"
        case offset = "offset"
        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        rows = try values.decodeIfPresent([Rows].self, forKey: .rows)
        cached = try values.decodeIfPresent(Bool.self, forKey: .cached)
        cachekey = try values.decodeIfPresent(String.self, forKey: .cachekey)
        checkedOrphan = try values.decodeIfPresent(Bool.self, forKey: .checkedOrphan)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }

}
