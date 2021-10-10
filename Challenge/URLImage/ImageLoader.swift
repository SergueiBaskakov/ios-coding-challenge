//
//  ImageLoader.swift
//  Challenge
//
//  Created by Serguei on 10/10/21.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?
    private var cancellable: AnyCancellable?
    var status: Status = .unknown
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL?) {
        self.url = url
        if url == nil {
            status = .failure
        }
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        if status != .failure {
            onStart()
            cancellable = URLSession.shared.dataTaskPublisher(for: url!)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .subscribe(on: Self.imageProcessingQueue)
                .receive(on: DispatchQueue.main)
                .sink {[weak self] completion in
                    self?.onFinish()
                } receiveValue: { [weak self] response in
                    self?.image = response
                    
                }
        }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func onStart() {
        status = .loading
    }
    
    private func onFinish() {
        if image != nil {
            status = .success
        }
        else {
            status = .failure
        }
    }
}

extension ImageLoader {
    enum Status {
        case unknown
        case loading
        case failure
        case success
    }
}
