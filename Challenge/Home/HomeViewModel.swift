//
//  HomeViewModel.swift
//  Challenge
//
//  Created by Serguei on 10/10/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var books: [Book] = []
    var anyCancellable = Set<AnyCancellable>()
    init(){
        updateBooks()
    }
    
    private func updateBooks(){
        BookRepository.getAllBooks()
            .sink { completion in
                if case .failure = completion {
                    print(completion)
                }
            } receiveValue: { books in
                self.books = books
            }
            .store(in: &anyCancellable)
    }
    
}
