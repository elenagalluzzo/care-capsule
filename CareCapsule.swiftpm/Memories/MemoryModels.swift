//
//  MemoryModels.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct MemoryModels {
    
    enum FormType: Identifiable, View {
        case new(UIImage, Binding<MemoryEntity>)
        case update(ImageEntity, Binding<MemoryEntity>)
        var id: String {
            switch self {
            case .new:
                return "new"
            case .update:
                return "update"
            }
        }
        var body: some View {
            switch self {
            case .new(let uiImage, let memoryEntity):
                return SetUpImagesView(viewModel: ImageSelectionViewModel(uiImage: uiImage), memory: memoryEntity)
            case .update(let imageEntity, let memoryEntity):
                return SetUpImagesView(viewModel: ImageSelectionViewModel(image: imageEntity), memory: memoryEntity)
            }
        }
    }
}
