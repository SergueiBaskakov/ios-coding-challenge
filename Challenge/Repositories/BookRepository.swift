//
//  BookRepository.swift
//  Challenge
//
//  Created by Serguei on 10/10/21.
//

import Foundation
import Combine

struct BookRepository {
    static func getAllBooks() -> AnyPublisher<[Book], Error>{
        
        return APIInteractor(scheme: .http, host: Environment.baseURL, path: "/books.json")
            .execute(method: .get, type: [Book].self)
        
    }
}
