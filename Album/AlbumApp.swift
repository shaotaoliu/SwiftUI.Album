import SwiftUI

@main
struct AlbumApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AlbumViewModel())
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
