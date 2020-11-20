//
//  PhotoFromTopic.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/19/20.
//

import Foundation

struct TopLevel: Codable {
    let topics: [PhotoFromTopic]
}

struct PhotoFromTopic: Codable {
    let urls: photoURLS
}

struct photoURLS: Codable {
    let small: URL
}
