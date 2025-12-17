//
//  FetchService.swift
//  BBQuotes
//
//  Created by Gina on 12.12.25.
//

import Foundation

struct FetchService {
    // we should consider access control by using the private statement, making the enum and the baseURL private
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    // https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    
    func fetchQuote(from show: String) async throws -> Quote {
        // build the fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL
            .appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // try to fetch the data
        let (data, response) = try await URLSession.shared.data(from: fetchURL) // built-in networking function
        
        // handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // 200 means everything is good
            throw FetchError.badResponse
        }
        
        // decode the data and put it into quote model
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // return quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Char {
        // build the fetch url
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL
            .appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        // try to fetch the data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // 200 means everything is good
            throw FetchError.badResponse
        }
        
        // decode the data and put it into the model, we have to deal with snake case
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Char].self, from: data)
        
        // return the character
        return characters[0] // return the first character in the collection (since it is the only one)
    }
    
    func fetchDeath(for character: String) async throws -> Death? { // return an optional death
        let fetchURL = baseURL.appending(path: "deaths")
        
        // try to fetch the data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // 200 means everything is good
            throw FetchError.badResponse
        }
        
        // decode the data and put it into the model, we have to deal with snake case
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        // find the death of the character we are talking about
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        
        return nil // it will only return nil if it didn't find a matching character in deaths
    }
}
