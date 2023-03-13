//
//  ImagePicker.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/03/23.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var text: String?
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(isPresented: $isPresented, image: $image, imageData: $imageData, text: $text)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            picker.sourceType = .photoLibrary
        } else {
            picker.sourceType = sourceType
        }
        
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
}

class ImagePickerViewCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @Binding var isPresented: Bool
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var text: String?
    
    init(isPresented: Binding<Bool>, image: Binding<Image?>, imageData: Binding<Data?>, text: Binding<String?>) {
        self._isPresented = isPresented
        self._image = image
        self._imageData = imageData
        self._text = text
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let width: CGFloat = 420.0
            let canva = CGSize(width: width, height: CGFloat(ceil(width / pickedImage.size.width * pickedImage.size.height)))
            
            let imgResized = UIGraphicsImageRenderer(size: canva, format: pickedImage.imageRendererFormat).image { _ in
                pickedImage.draw(in: CGRect(origin: .zero, size: canva))
            }
            
            self.image = Image(uiImage: imgResized)
            self.imageData = imgResized.jpegData(compressionQuality: 0.2)
            self.text = "Foto carregada com sucesso 💅"
            self.isPresented = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}


