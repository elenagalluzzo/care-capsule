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
        NavigationLink(destination: getDestination(memory: memory, viewModel: viewModel)) {
            VStack {
                HStack {
                    if !memory.images.isEmpty && !memory.images[0].id.isEmpty {
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
    
    func getDestination(memory: MemoryEntity, viewModel: ImageSelectionViewModel) -> AnyView? {
        if !memory.images.isEmpty {
                return AnyView(MemoryGalleryView(memory: memory, viewModel: viewModel))
            } else {
                return nil
            }
        }
   
}
