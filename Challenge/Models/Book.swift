//
//  Book.swift
//  Challenge
//
//  Created by Serguei on 10/10/21.
//

import Foundation

struct Book: Codable, Hashable{
    let id = UUID()
    let imageURL: URL?
    let title: String
    let author: String?
}
