//
//  PeopleModels.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct PeopleModels {
    
    struct CellModel: Identifiable {
        let id = UUID()
        let name: String
        let profileImageName: String?
        let images: [Image]?
    }
    
    struct Image: Identifiable {
        let id = UUID()
        let imageName: String?
        let imageDescription: String?
    }
    
}
