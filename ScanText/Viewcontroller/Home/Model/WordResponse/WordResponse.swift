//
//  WordResponse.swift
//  ScanText
//
//  Created by Saravanan on 18/09/21.
//

import Foundation
struct  WordResponse: Codable {
    let word : String?
    let results : [Results]?
    let syllables : Syllables?
    let pronunciation : Pronunciation?
    let frequency : Double?
    
    var arrSynonyms :  [String]?
    var arrAntonyms :  [String]?
    var arrThesaurus : [String]?
    
    enum CodingKeys: String, CodingKey {

        case word = "word"
        case results = "results"
        case syllables = "syllables"
        case pronunciation = "pronunciation"
        case frequency = "frequency"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        word = try values.decodeIfPresent(String.self, forKey: .word)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
        syllables = try values.decodeIfPresent(Syllables.self, forKey: .syllables)
        pronunciation = try values.decodeIfPresent(Pronunciation.self, forKey: .pronunciation)
        frequency = try values.decodeIfPresent(Double.self, forKey: .frequency)
        constructValues()
    }
    

}


extension WordResponse{
    mutating func constructValues(){
        let arryOFSynonyms = results?.compactMap({ (resultModel) -> [String]? in
            return resultModel.synonyms
        })
        arrSynonyms = arryOFSynonyms?.reduce([], +).map { $0.capitalized}
        
        let arryOFAntonyms = results?.compactMap({ (resultModel) -> [String]? in
            return resultModel.antonyms
        })
        arrAntonyms = arryOFAntonyms?.reduce([], +).map { $0.capitalized}
        
        let arryOFThesaurus = results?.compactMap({ (resultModel) -> [String]? in
            return resultModel.hasTypes
        })
        arrThesaurus = arryOFThesaurus?.reduce([], +).map { $0.capitalized}
    }
}
