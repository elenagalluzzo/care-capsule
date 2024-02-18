//
//  MemoryViewModel.swift
//
//
//  Created by Elena Galluzzo on 2024-02-03.
//

import SwiftUI

@MainActor
final class MemoryViewModel: ObservableObject {
//    @Published private(set) var image: UIImage? = nil
    @Published var memoryPrompt = AssistantModels.Prompts.memories
}

