//
//  Layout.swift
//  ScanText
//
//  Created by Saravanan on 20/09/21.
//

import Foundation
struct Layout : Codable {
    let id : Int?
    let name : String?
    let css : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case css = "css"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        css = try values.decodeIfPresent(String.self, forKey: .css)
    }

}
