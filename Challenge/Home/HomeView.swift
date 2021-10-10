//
//  HomeView.swift
//  Challenge
//
//  Created by Serguei on 10/10/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.books, id: \.self) { book in
                    BookCard(image: book.imageURL, title: book.title, author: book.author)
                }
            }
            .padding()
        }
    }
}

struct BookCard: View {
    let image: URL?
    let title: String
    let author: String?
    
    var body: some View {
        VStack{
            HStack() {
                URLImage(url: image) {
                    Image(uiImage: $0)
                        .resizable()
                } placeholder: {
                    Text("Loading ...")
                } onFailure: {
                        Text("No Image")

                }
                .scaledToFit()
                .frame(width: 100, height: 120, alignment: .center)
                
                
                VStack(alignment: .leading) {
                    Text(title)
                        .lineLimit(nil)
                    if author != nil {
                        Text("Author: \(author ?? "")")
                            .lineLimit(nil)
                            .font(.system(size: 15))
                            .padding(.top, 2)
                    }
                    Spacer()
                }
                Spacer()
            }
            Rectangle()
                .frame(height: 1, alignment: .center)
                .padding(.vertical)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        BookCard(image: URL(string: "http://i.ebayimg.com/00/$T2eC16F,!)kE9s4Z-Ue7BRb4ZE0oog~~_6.JPG?set_id=89040003C1"), title: "Harry Potter Years 1-7 by J. K. Rowling and Inc. Staff Scholastic (2007, Hardcover)", author: "J.K. Rowling")
    }
}
