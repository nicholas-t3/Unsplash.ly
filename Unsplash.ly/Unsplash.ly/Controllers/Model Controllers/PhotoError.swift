//
//  PhotoError.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/18/20.
//

import Foundation

enum PhotoError: LocalizedError {
    case genericError
    
    var errorDescription: String {
        switch self {
        case .genericError:
            return("Default")
        }
    }
}
