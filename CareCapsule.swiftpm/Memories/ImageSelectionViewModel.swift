//
//  ImageSelectionViewModel.swift
//  
//
//  Created by Elena Galluzzo on 2024-02-04.
//

import UIKit

class ImageSelectionViewModel: ObservableObject {
    @Published var description = ""
    @Published var uiImage: UIImage
    
    var id: String?
    var updating: Bool {id != nil}
    
    init(uiImage: UIImage) {
        self.uiImage = uiImage
  
    }
    
    init(image: ImageEntity) {
        self.description = image.descrip
        self.uiImage = image.uiImage
        self.id = image.id
        
    }
    
    var incomplete: Bool {
        uiImage == UIImage(systemName: "photo")
    }
}
