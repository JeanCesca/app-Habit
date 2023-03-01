//
//  ImageView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 01/03/23.
//

import SwiftUI
import Combine

struct ImageView: View {
    
    @ObservedObject var imageLoader: ImageLoader
//    @State var image: UIImage = UIImage()
        
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {

//        var image = UIImage(data: imageLoader.data) ?? UIImage()
        
        Image(uiImage: imageLoader.image)
            .resizable()
        
//        Image(uiImage: image)
//            .resizable()
//            .onReceive(imageLoader.didChange) { data in
//                self.image = UIImage(data: data) ?? UIImage()
//            }
    }
}

class ImageLoader: ObservableObject {
    
//    var didChange = PassthroughSubject<Data, Never>()
    
//    var data = Data() {
//        didSet {
//            didChange
//                .send(data)
//        }
//    }
    
//    @Published var data: Data = Data()
    @Published var image: UIImage = UIImage()
    
    
    init(url: String) {
        fetchImage(url: url)
    }
    
    private func fetchImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, request, error in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage(systemName: "person")!
            }
        }
        .resume()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "https://google.com")
    }
}
