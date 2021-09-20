//
//  Network.swift
//  ScanText
//
//  Created by Saravanan on 20/09/21.
//

import Foundation
struct Network : Codable {
    let id : Int?
    let brand_url : String?
    let css_class : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case brand_url = "brand_url"
        case css_class = "css_class"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        brand_url = try values.decodeIfPresent(String.self, forKey: .brand_url)
        css_class = try values.decodeIfPresent(String.self, forKey: .css_class)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
