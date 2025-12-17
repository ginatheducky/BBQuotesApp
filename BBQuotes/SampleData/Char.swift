//
//  Char.swift
//  BBQuotes
//
//  Created by Gina on 12.12.25.
//

import Foundation

struct Char: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL] // swift has an automatic converter to turn Strings into URL
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death?
}
