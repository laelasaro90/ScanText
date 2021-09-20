//
//  Results.swift
//  ScanText
//
//  Created by Saravanan on 18/09/21.
//

import Foundation
struct Results : Codable {
    let definition : String?
    let partOfSpeech : String?
    let synonyms : [String]?
    let typeOf : [String]?
    let hasTypes : [String]?
    let antonyms : [String]?
    let examples : [String]?

    enum CodingKeys: String, CodingKey {

        case definition = "definition"
        case partOfSpeech = "partOfSpeech"
        case synonyms = "synonyms"
        case typeOf = "typeOf"
        case hasTypes = "hasTypes"
        case antonyms = "antonyms"
        case examples = "examples"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        definition = try values.decodeIfPresent(String.self, forKey: .definition)
        partOfSpeech = try values.decodeIfPresent(String.self, forKey: .partOfSpeech)
        synonyms = try values.decodeIfPresent([String].self, forKey: .synonyms)
        typeOf = try values.decodeIfPresent([String].self, forKey: .typeOf)
        hasTypes = try values.decodeIfPresent([String].self, forKey: .hasTypes)
        antonyms = try values.decodeIfPresent([String].self, forKey: .antonyms)
        examples = try values.decodeIfPresent([String].self, forKey: .examples)
    }

}
