//
//  Rows.swift
//  ScanText
//
//  Created by Saravanan on 20/09/21.
//

import Foundation
struct Rows : Codable {
    let id : Int?
    let media_key : String?
    let feed_id : Int?
    let feed_name : String?
    let from_user_name : String?
    let from_full_name : String?
    let profile_url : String?
    let media_type_id : Int?
    let perma_link : String?
    let source : String?
    let official_brand_url : String?
    let votes : Int?
    let image_width : Int?
    let image_height : Int?
    let image_url : String?
    let images : [Images]?
    let status : Int?
    let created_at : Int?
    let imported_at : Int?
    let descript : String?
    let target_url : String?
    let is_retweet : Bool?
    let network : Network?
    let layout : Layout?
    let has_body : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case media_key = "media_key"
        case feed_id = "feed_id"
        case feed_name = "feed_name"
        case from_user_name = "from_user_name"
        case from_full_name = "from_full_name"
        case profile_url = "profile_url"
        case media_type_id = "media_type_id"
        case perma_link = "perma_link"
        case source = "source"
        case official_brand_url = "official_brand_url"
        case votes = "votes"
        case image_width = "image_width"
        case image_height = "image_height"
        case image_url = "image_url"
        case images = "images"
        case status = "status"
        case created_at = "created_at"
        case imported_at = "imported_at"
        case descript = "description"
        case target_url = "target_url"
        case is_retweet = "is_retweet"
        case network = "network"
        case layout = "layout"
        case has_body = "has_body"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        media_key = try values.decodeIfPresent(String.self, forKey: .media_key)
        feed_id = try values.decodeIfPresent(Int.self, forKey: .feed_id)
        feed_name = try values.decodeIfPresent(String.self, forKey: .feed_name)
        from_user_name = try values.decodeIfPresent(String.self, forKey: .from_user_name)
        from_full_name = try values.decodeIfPresent(String.self, forKey: .from_full_name)
        profile_url = try values.decodeIfPresent(String.self, forKey: .profile_url)
        media_type_id = try values.decodeIfPresent(Int.self, forKey: .media_type_id)
        perma_link = try values.decodeIfPresent(String.self, forKey: .perma_link)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        official_brand_url = try values.decodeIfPresent(String.self, forKey: .official_brand_url)
        votes = try values.decodeIfPresent(Int.self, forKey: .votes)
        image_width = try values.decodeIfPresent(Int.self, forKey: .image_width)
        image_height = try values.decodeIfPresent(Int.self, forKey: .image_height)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        images = try values.decodeIfPresent([Images].self, forKey: .images)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(Int.self, forKey: .created_at)
        imported_at = try values.decodeIfPresent(Int.self, forKey: .imported_at)
        descript = try values.decodeIfPresent(String.self, forKey: .descript)
        target_url = try values.decodeIfPresent(String.self, forKey: .target_url)
        is_retweet = try values.decodeIfPresent(Bool.self, forKey: .is_retweet)
        network = try values.decodeIfPresent(Network.self, forKey: .network)
        layout = try values.decodeIfPresent(Layout.self, forKey: .layout)
        has_body = try values.decodeIfPresent(Bool.self, forKey: .has_body)
    }

}
