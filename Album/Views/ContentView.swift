import SwiftUI

struct ContentView: View {
    
    @AppStorage("album.columns") private var columns: Int = 3
    @EnvironmentObject private var vm: AlbumViewModel
    @State private var showAddSheet = false
    @State private var showSettingSheet = false

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(0..<getNumOfRows(), id: \.self) { row in
                        ImageGridRow(images: getImagesInRow(row), columns: columns)
                    }
                }
            }
            .navigationBarTitle("My Album")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: SettingsButton, trailing: AddButton)
        }
    }
    
    func getNumOfRows() -> Int {
        return vm.images.count % columns == 0 ? vm.images.count / columns : vm.images.count / columns + 1
    }
    
    func getImagesInRow( _ row: Int) -> [AlbumImage] {
        let start = row * columns
        let end = min(start + columns, vm.images.count)
        return Array(vm.images[start..<end])
    }
    
    var SettingsButton: some View {
        Button(action: {
            showSettingSheet = true
        }, label: {
            Image(systemName: "gearshape")
        })
            .sheet(isPresented: $showSettingSheet) {
                SettingsView()
            }
    }
    
    var AddButton: some View {
        Button(action: {
            showAddSheet = true
        }, label: {
            Image(systemName: "plus")
        })
            .sheet(isPresented: $showAddSheet, onDismiss: {
                vm.load()
            }) {
                AddImageView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AlbumViewModel())
    }
}
