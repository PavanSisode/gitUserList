//
//  ImageLoader.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import Foundation
import SwiftUI
import Combine
class ImageLoader: ObservableObject {
    typealias DTP = AnyPublisher <
        URLSession.DataTaskPublisher.Output,
        URLSession.DataTaskPublisher.Failure>
    
    @Published var image : UIImage?
    var storage = Set<AnyCancellable>()
    private let urlString: String
    private var cache: ImageCache?
    
    init(_ urlString: String, cache: ImageCache? = nil) {
        self.urlString = urlString
        self.cache = cache
    }
    
    func fetchImage() {
        guard let url = URL(string:self.urlString) else { return }
        if let image = cache?[url] {
            self.image = image
            return
        }
        self.getImage(url:url)
    }
    
    private func getImage(url:URL) {
        let pub = self.dataTaskPublisher(for: url)
        self.createPipelineFromPublisher(pub: pub)
    }
    
    private func dataTaskPublisher(for url: URL) -> DTP {
        URLSession.shared.dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
    
    func createPipelineFromPublisher(pub: DTP) {
        pub
            .compactMap { UIImage(data:$0.data) }
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] image in
                self?.image = image
                self?.cache(image)
            }
            .store(in: &self.storage)
    }
    
    private func cache(_ image: UIImage?) {
        guard let url = URL(string:self.urlString) else { return }
        image.map { cache?[url] = $0 }
    }
}
