//
//  Pronunciation.swift
//  ScanText
//
//  Created by Saravanan on 18/09/21.
//

import Foundation
struct Pronunciation : Codable {
    let all : String?

    enum CodingKeys: String, CodingKey {

        case all = "all"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all = try values.decodeIfPresent(String.self, forKey: .all)
    }

}
