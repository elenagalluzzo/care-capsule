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
    
    init(title: String = "", descrip: String = "", frequency: String = "once", checked: Bool = false, dateOfTask: Date = Date()) {
        self.title = title
        self.descrip = descrip
        self.checked = checked
        self.dateOfTask = dateOfTask
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
    var frequencyValue: ReminderModels.Frequency {
        get {
            ReminderModels.Frequency(rawValue: frequency) ?? .once
        }
        set {
            self.frequency = newValue.rawValue
        }
    }
    
    init(title: String = "", frequency: String = "once", checked: Bool = false, firstDate: Date = Date(), endDate: Date? = nil) {
        self.title = title
        self.frequency = frequency
        self.checked = checked
        self.firstDate = firstDate
        self.endDate = endDate
    }
}






//import CoreData
//
//@objc(TaskEntity)
//public class TaskEntity: NSManagedObject, Identifiable {
//    @NSManaged public var id: UUID
//    @NSManaged public var title: String
//    @NSManaged public var descrip: String?
//    @NSManaged public var frequency: String
//    @NSManaged public var checked: Bool
//    @NSManaged public var dateOfTask: Date
//    
//    var frequencyValue: ReminderModels.Frequency {
//        get {
//            ReminderModels.Frequency(rawValue: frequency) ?? .once
//        }
//        set {
//            self.frequency = newValue.rawValue
//        }
//    }
//   
//}
//
//@objc(MedicationEntity)
//public class MedicationEntity: NSManagedObject {
//    @NSManaged public var id: UUID
//    @NSManaged public var title: String
//    @NSManaged public var frequency: String?
//    @NSManaged public var checked: Bool
//    @NSManaged public var firstDate: Date
//    @NSManaged public var endDate: Date?
//}