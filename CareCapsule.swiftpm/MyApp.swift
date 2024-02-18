import SwiftUI
import SwiftData

@available(iOS 17.0, *)
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(PillsViewModel())
                .environmentObject(TaskViewModel())
                .environmentObject(MemoryViewModel())
                .environmentObject(ImageSelectionViewModel(uiImage: UIImage()))
        }
        .modelContainer(for: [TaskEntity.self, MedicationEntity.self, MemoryEntity.self, ImageEntity.self])
    }
}
