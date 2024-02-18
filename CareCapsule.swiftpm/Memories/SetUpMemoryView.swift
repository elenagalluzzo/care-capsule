//
//  SetUpMemoryView.swift
//
//
//  Created by Elena Galluzzo on 2024-02-03.
//

import SwiftUI
import SwiftData
import PhotosUI
import UIKit

struct SetUpMemoryView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var showSetUp: Bool
    @StateObject private var imagePicker = ImagePicker()
    @State var memory: MemoryEntity = MemoryEntity()
    @State private var formType: MemoryModels.FormType?
    @ObservedObject var viewModel: ImageSelectionViewModel
    
//    var images: [ImageEntity]

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title of Memory/ Person", text: $memory.name)
                PhotosPicker("Add Images", selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared())
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(memory.images) { image in
                            VStack {
                                if !image.id.isEmpty{
                                    Image(uiImage: image.uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                }
                Spacer()
                Button("Add") {
                    modelContext.insert(memory)
                    try? modelContext.save()
                    showSetUp = false
                }
                .tint(Color("capsuleDarkOrange"))
                .buttonStyle(.borderedProminent)
            }
            .onChange(of: imagePicker.uiImage) { _, newImage in
                if let newImage {
                    formType = .new(newImage, $memory)
                }
            }
            .sheet(item: $formType) {$0}
        }
    }
}

//#Preview {
//    SetUpMemoryView()
//}
