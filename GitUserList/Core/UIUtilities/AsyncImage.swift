//
//  AsyncImage.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import Foundation
import SwiftUI
import Combine

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(urlString: String,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(urlString, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.fetchImage)
    }
    
    private var content: some View {
        Group {
            if let loaderImage = loader.image {
                image(loaderImage)
            } else {
                placeholder
            }
        }
    }
}
