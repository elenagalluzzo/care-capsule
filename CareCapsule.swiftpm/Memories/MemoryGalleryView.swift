//
//  MemoryGalleryView.swift
//
//
//  Created by Elena Galluzzo on 2024-02-15.
//

import SwiftUI

struct MemoryGalleryView: View {
    @State var memory: MemoryEntity
    @ObservedObject var viewModel: ImageSelectionViewModel
    @Environment(\.modelContext) var modelContext
    let columns = [GridItem(.adaptive(minimum: 100))]
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(memory.images) { image in
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        FileManager().deleteImageFromDirectory(with: image.id)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                                if !image.id.isEmpty {
//                                    let pic: UIImage = FileManager().retrieveImageFromDirectory(with: image.id) ?? UIImage()
                                    Image(uiImage: image.uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                        .padding(.horizontal, 20)
                                }
                                Text(image.descrip)
                                    .font(.caption)
                            }
                        }
                    }
                    
                }
            }
            .background(Color("capsuleLightOrange").opacity(0.3))
        }
        .navigationTitle(memory.name)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color("capsuleDarkOrange"),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

//#Preview {
//    MemoryGalleryView()
//}
