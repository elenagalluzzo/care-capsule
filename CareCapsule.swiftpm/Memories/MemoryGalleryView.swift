//
//  MemoryGalleryView.swift
//
//
//  Created by Elena Galluzzo on 2024-02-15.
//

import SwiftUI
import PhotosUI

struct MemoryGalleryView: View {
    @State var memory: MemoryEntity
    @ObservedObject var viewModel: ImageSelectionViewModel
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var imageViewModel: ImageSelectionViewModel
    @StateObject private var imagePicker = ImagePicker()
    @State private var formType: MemoryModels.FormType?
    let columns = [GridItem(.adaptive(minimum: 130))]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(memory.images) { image in
                            VStack {
                                if !image.id.isEmpty {
                                    Image(uiImage: image.uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                        .padding()
                                }
                                Text(image.descrip)
                                    .font(.callout)
                            }
                        }
                        .onDelete(perform: deleteImage)
                    }
                    .padding()
                }
            }
            .background(Color("capsuleLightOrange").opacity(0.3))
        }
        .navigationTitle(memory.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                PhotosPicker("Add Images", selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared())
                
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color("capsuleDarkOrange"),
            for: .navigationBar)
        .safeAreaInset(edge: .bottom, spacing: 5) {
            Group {
                MiniAssistantHelperView(prompt: .setUpImages, isTalking: true)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .onChange(of: imagePicker.uiImage) { _, newImage in
            if let newImage {
                formType = .new(newImage, $memory)
            }
        }
        .sheet(item: $formType) {$0}
    }
    func deleteImage(_ indexSet: IndexSet) {
        for index in indexSet {
            let image = memory.images[index]
            modelContext.delete(image)
        }
    }
}

