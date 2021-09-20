//
//  Images.swift
//  ScanText
//
//  Created by Saravanan on 20/09/21.
//

import Foundation
struct Images : Codable {
    let url : String?
    let height : Int?
    let width : Int?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case height = "height"
        case width = "width"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
    }

}
