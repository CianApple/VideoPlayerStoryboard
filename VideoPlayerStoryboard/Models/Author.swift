//
//  Author.swift
//  VideoPlayerStoryboard
//
//  Created by Jai Dhorajia on 2022-08-10.
//

import Foundation

struct Author : Codable {
    let id : String?
    let name : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
