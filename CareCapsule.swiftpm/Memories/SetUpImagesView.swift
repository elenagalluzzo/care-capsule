//
//  SetUpImagesView.swift
//
//
//  Created by Elena Galluzzo on 2024-02-07.
//

import SwiftUI
import PhotosUI
import SwiftData

struct SetUpImagesView: View {
    @ObservedObject var viewModel: ImageSelectionViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var imagePicker = ImagePicker()
    @Environment(\.modelContext) var modelContext
    @Binding var memory: MemoryEntity
    
    @Query var images: [ImageEntity]
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: viewModel.uiImage)
                    .resizable()
                    .scaledToFit()
                HStack (alignment: .center) {
                    Spacer()
                    TextField("Write something about this memory.", text: $viewModel.description)
                    Spacer()
                }
                HStack {
                    if viewModel.updating {
                        PhotosPicker("Change description", selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared())
                    }
                    Button {
                        if viewModel.updating {
                            if let id = viewModel.id,
                               let selectedImage = images.first(where: {$0.id == id}) {
                                selectedImage.descrip = viewModel.description
                                FileManager().saveImageToDirectory(with: id, image: viewModel.uiImage)
                                if modelContext.hasChanges {
                                    try? modelContext.save()
                                }
                            }
                        } else {
                            let newImage = ImageEntity()
                            newImage.descrip = viewModel.description
                            newImage.id = UUID().uuidString
                            modelContext.insert(newImage)
                            FileManager().saveImageToDirectory(with: newImage.id, image: viewModel.uiImage)
                            memory.images.append(newImage)
                        }
                        dismiss()
                    } label: {
                        Text("Save Image to Memory")
                    }
                    .tint(Color("capsuleDarkOrange"))
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.incomplete)
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .tint(Color("capsuleDarkOrange"))
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.incomplete)
                }
            }
            .padding()
            .navigationTitle(viewModel.updating ? "Update" : "Add Image to Memory")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: imagePicker.uiImage) { _, newImage in
            if let newImage {
                viewModel.uiImage = newImage
            }
        }
    }
}


//#Preview {
   // SetUpImagesView(viewModel: ImageSelectionViewModel(uiImage: UIImage(systemName: "photo")!))
//}
