import SwiftUI
import ImagePicker

struct ImageDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var albumVM: AlbumViewModel
    var image: AlbumImage
    
    var body: some View {
        NavigationView {
            ZoomableScrollView {
                Image(uiImage: image.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    VStack {
                        Divider()
                        
                        Button(action: {
                            try? AlbumManager.shared.delete(image: image)
                            albumVM.load()
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "trash")
                        })
                    }
                }
            }
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(image: AlbumViewModel.preview.images[0])
            .environmentObject(AlbumViewModel())
    }
}
