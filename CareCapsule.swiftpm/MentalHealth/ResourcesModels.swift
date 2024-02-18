//
//  ResourcesModels.swift
//
//
//  Created by Elena Galluzzo on 2024-01-31.
//

import Foundation

struct ResourcesModels {
    
    struct Resource: Identifiable {
        let id = UUID()
        let name: String
        let description: String
    }

}
