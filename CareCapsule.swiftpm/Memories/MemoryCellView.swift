//
//  MemoryCellView.swift
//
//
//  Created by Elena Galluzzo on 2024-02-15.
//

import SwiftUI

struct MemoryCellView: View {
    @State var memory: MemoryEntity
    @ObservedObject var viewModel: ImageSelectionViewModel
    var body: some View {
        NavigationLink(destination: MemoryGalleryView(memory: memory, viewModel: viewModel)) {
            VStack {
                HStack {
                    if !memory.images.isEmpty && !memory.images[0].id.isEmpty {
//                        let pic: UIImage = FileManager().retrieveImageFromDirectory(with: memory.images[0].id) ?? UIImage()
                        Image(uiImage: memory.images[0].uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .cornerRadius(5)
                            .padding(.leading, 8)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .cornerRadius(5)
                            .padding(.leading, 8)
                    }
                    Text(memory.name)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
    }
}

//#Preview {
//    MemoryCellView()
//}
