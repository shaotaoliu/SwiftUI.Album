import SwiftUI

struct ImageGridRow: View {
    
    var images: [AlbumImage]
    var columns = 3
    let spacing = 2
    
    var body: some View {
        HStack(spacing: CGFloat(spacing)) {
            ForEach(images, id: \.id) { item in
                NavigationLink(destination: {
                    ImageDetailView(image: item)
                }, label: {
                    Image(uiImage: item.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageSize, height: imageSize)
                        .clipped()
                })
            }
            
            Spacer()
        }
    }
    
    var imageSize: CGFloat {
        let spaces = (columns - 1) * spacing
        return (UIScreen.main.bounds.width - CGFloat(spaces)) / CGFloat(columns)
    }
}

struct ImageGridRow_Previews: PreviewProvider {
    static var previews: some View {
        let n = 3
        ImageGridRow(images: Array(AlbumViewModel.preview.images[0..<n]), columns: n)
    }
}
