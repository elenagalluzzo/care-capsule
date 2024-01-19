import SwiftUI
import SwiftData
//import CoreML

@available(iOS 17.0, *)
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .modelContainer(for: [TaskEntity.self, MedicationEntity.self])
    }
}
