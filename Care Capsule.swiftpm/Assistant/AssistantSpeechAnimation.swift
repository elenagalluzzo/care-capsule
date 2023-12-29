//
//  AssistantSpeechAnimation.swift
//
//
//  Created by Elena Galluzzo on 2023-12-27.
//

import SwiftUI

struct AssistantSpeechAnimation: UIViewRepresentable {
    
    let imageNames: [String] = ["Assistant-1", "Assistant-2", "Assistant-3", "Assistant-4", "Assistant-5"]
    let duration: Double = 0.5
    
    func makeUIView(context: Self.Context) -> UIView {
        let imageView = UIImageView()
        var images = [UIImage]()
        imageView.clipsToBounds = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
            imageNames.forEach { imageName in
                if let image = UIImage(named: imageName) {
                    images.append(image)
                }
            }
        imageView.image = UIImage.animatedImage(with: images, duration: duration)
        return imageView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
  
} 
