import UIKit

class AlbumManager {
    
    static let shared = AlbumManager()
    
    private let albumDir: URL
    private let fileManager: FileManager
    
    private init() {
        let root = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        albumDir = root.appendingPathComponent("Album")
        fileManager = FileManager()
        
        if !fileManager.fileExists(atPath: albumDir.path) {
            try! FileManager.default.createDirectory(atPath: albumDir.path, withIntermediateDirectories: true)
        }
    }
    
    func save(image: AlbumImage) throws {
        let url = albumDir.appendingPathComponent(image.id)
        let data = image.image.pngData()!
        try data.write(to: url)
    }
    
    func create(image: AlbumImage) {
        let url = albumDir.appendingPathComponent(image.id)
        let data = image.image.pngData()!
        fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
    }
    
    func delete(image: AlbumImage) throws {
        let url = albumDir.appendingPathComponent(image.id)
        try fileManager.removeItem(at: url)
    }

    func loadImages() throws -> [AlbumImage] {
        if !fileManager.fileExists(atPath: albumDir.path) {
            return []
        }
        
        let urls = try FileManager.default.contentsOfDirectory(at: albumDir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        var images = [AlbumImage]()

        for url in urls {
            let data = try! Data(contentsOf: url)
            images.append(AlbumImage(id: url.lastPathComponent, image: UIImage(data: data)!))
        }
        
        return images
    }
}
