//
//  Quote.swift
//  BBQuotes
//
//  Created by Gina on 12.12.25.
//

// we need to conform to decodable because we are conforming to JSON data
struct Quote: Decodable {
    let quote: String
    let character: String
}
