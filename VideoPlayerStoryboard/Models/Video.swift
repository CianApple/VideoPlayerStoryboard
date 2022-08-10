//
//  Video.swift
//  VideoPlayerStoryboard
//
//  Created by Jai Dhorajia on 2022-08-10.
//

import Foundation

struct Video : Codable {
    let id : String?
    let title : String?
    let hlsURL : URL?
    let fullURL : URL?
    let description : String?
    let publishedAt : String?
    let author : Author?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case hlsURL = "hlsURL"
        case fullURL = "fullURL"
        case description = "description"
        case publishedAt = "publishedAt"
        case author = "author"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        hlsURL = try values.decodeIfPresent(URL.self, forKey: .hlsURL)
        fullURL = try values.decodeIfPresent(URL.self, forKey: .fullURL)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        author = try values.decodeIfPresent(Author.self, forKey: .author)
    }
}
