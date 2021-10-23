import SwiftUI

struct AlbumImage {
    
    let id: String
    let image: UIImage
    
    init(id: String, image: UIImage) {
        self.id = id
        self.image = image
    }
    
    init(image: UIImage) {
        self.id = UUID().uuidString
        self.image = image
    }
}
