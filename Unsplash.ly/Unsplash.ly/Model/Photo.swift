//
//  Photo.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/18/20.
//

import Foundation

struct Photo: Codable {
   let urls: urls
}

struct urls: Codable {
    let regular: URL
}
