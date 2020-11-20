//
//  Topic.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/18/20.
//

import Foundation

struct TopLevelDictionary: Codable {
    let topics: [Topic]
}

struct Topic: Codable {
    let title: String
    var coverPhoto: CoverPhoto
    
    enum CodingKeys: String, CodingKey {
        case coverPhoto = "cover_photo"
        case title
    }
}

struct CoverPhoto: Codable {
    let urls: URLS
}

struct URLS: Codable {
    let small: URL
}
