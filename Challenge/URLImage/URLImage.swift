//
//  URLImage.swift
//  Challenge
//
//  Created by Serguei on 10/10/21.
//

import Foundation
import SwiftUI

public struct URLImage<NoImageView: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: NoImageView
    private let onFailure: NoImageView
    private let image: (UIImage) -> Image
    
    public init(
        url: URL?,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:),
        @ViewBuilder placeholder: () -> NoImageView,
        @ViewBuilder onFailure: () -> NoImageView
    ) {
        self.placeholder = placeholder()
        self.onFailure = onFailure()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url))

    }
    
    public var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            switch loader.status {
            case .unknown:
                placeholder
            case .loading:
                placeholder
            case .success:
                image(loader.image!)
            case .failure:
                onFailure
            }
        }
    }
}
