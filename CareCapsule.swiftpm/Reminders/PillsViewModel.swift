//
//  PillsViewModel.swift
//  
//
//  Created by Elena Galluzzo on 2024-01-30.
//

import Foundation
import SwiftUI

class PillsViewModel: ObservableObject {
    @Published var pillsPrompt = AssistantModels.Prompts.setUpPill
}
