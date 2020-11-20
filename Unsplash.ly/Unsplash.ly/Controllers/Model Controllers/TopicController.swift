//
//  TopicController.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/18/20.
//

import Foundation
import UIKit

class TopicController {
    static let baseURL = URL(string: "https://api.unsplash.com/")
    static let clientKey = "UjBpymnLHPtmPk9ei8D36UCdRinK91YYjVkEKeShFys"
    static let topicsComponent = "topics"
    
    static func fetchTopic(completion: @escaping (Result<[Topic], TopicError>) -> Void) {
        
        guard let baseURL = baseURL else {return completion(.failure(.genericError))}
        
        let componentURL = baseURL.appendingPathComponent(topicsComponent)
        var components = URLComponents(url: componentURL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [URLQueryItem(name: "client_id", value: clientKey)]
        guard let finalURL = components?.url else {return completion(.failure(.genericError))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print (error.localizedDescription)
                return completion(.failure(.genericError))
            }
            
            guard let data = data else {return completion(.failure(.genericError))}
            
            do {
                let topics = try JSONDecoder().decode([Topic].self, from: data)
                return completion(.success(topics))
            } catch {
                return completion(.failure(.genericError))
            }
        } .resume()
        
    }
    
    static func fetchCoverPhoto(topic: Topic, completion: @escaping (Result<UIImage, TopicError>) -> Void) {
        
        let url = topic.coverPhoto.urls.small
       
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            
            guard let data = data else {return completion(.failure(.genericError))}
            guard let image = UIImage(data: data) else {return completion(.failure(.genericError))}
            return completion(.success(image))
        } .resume()
        
    }
        
        
    } // End of class


