import SwiftUI

class AlbumViewModel: ViewModel {
    
    @Published var images: [AlbumImage] = []
    
    override init() {
        super.init()
        load()
    }
    
    func load() {
        do {
           images = try AlbumManager.shared.loadImages()
        }
        catch {
            errorMessage = error.localizedDescription
        }
    }
}
