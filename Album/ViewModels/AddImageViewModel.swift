import SwiftUI
import ImagePicker

class AddImageViewModel: ViewModel {
    
    @Published var showCameraSheet = false
    @Published var selectedImage: UIImage? = nil
    @Published var sourceType = ImagePicker.SourceType.library
    
    func showImagePicker(sourceType: ImagePicker.SourceType) {
        if sourceType == .camera {
            do {
                try ImagePicker.checkCameraStatus()
            }
            catch {
                self.errorMessage = error.localizedDescription
                return
            }
        }
        
        self.sourceType = sourceType
        self.showCameraSheet = true
    }
    
    func save() -> Bool {
        guard let image = selectedImage else {
            errorMessage = "Please choose image"
            return false
        }
        
        do {
            let newImage = AlbumImage(image: image)
            try AlbumManager.shared.save(image: newImage)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return true
    }
}
