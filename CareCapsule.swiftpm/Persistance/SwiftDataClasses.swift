//
//  CoreDataClasses.swift
//
//
//  Created by Elena Galluzzo on 2023-12-29.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
@Model
final class TaskEntity {
    var title: String
    var descrip: String
    var checked: Bool
    var dateOfTask: Date
    var frequency: String
    
    init(title: String = "", descrip: String = "", frequency: String = "once", checked: Bool = false, dateOfTask: Date = Date()) {
        self.title = title
        self.descrip = descrip
        self.checked = checked
        self.dateOfTask = dateOfTask
        self.frequency = frequency
    }
}

@available(iOS 17.0, *)
@Model
final class MedicationEntity {
    var title: String
    var frequency: String
    var checked: Bool
    var firstDate: Date
    var endDate: Date?
    
    init(title: String = "", frequency: String = "once", checked: Bool = false, firstDate: Date = Date(), endDate: Date? = nil) {
        self.title = title
        self.frequency = frequency
        self.checked = checked
        self.firstDate = firstDate
        self.endDate = endDate
    }
}

@available(iOS 17.0, *)
@Model
final class MemoryEntity {
    var id = UUID()
    var name: String
    var images: [ImageEntity] = []

    init(name: String = "", images: [ImageEntity] = []) {
        self.name = name
        self.images = images
    }
}

@available(iOS 17.0, *)
@Model
final class ImageEntity {
    var id: String
    var descrip: String
    var uiImage: UIImage {
        if !id.isEmpty,
           let image = FileManager().retrieveImageFromDirectory(with: id) {
            return image
        } else {
            return UIImage(systemName: "photo")!
        }
    }
    
    init(id: String = "", descrip: String = "") {
        self.id = id
        self.descrip = descrip
    }
}




