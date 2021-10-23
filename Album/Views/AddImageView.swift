import SwiftUI
import ImagePicker

struct AddImageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var vm = AddImageViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        vm.showImagePicker(sourceType: .camera)
                    }, label: {
                        ImageLabel(title: "Camera", systemImage: "camera")
                    })
                    
                    Button(action: {
                        vm.showImagePicker(sourceType: .library)
                    }, label: {
                        ImageLabel(title: "Photos", systemImage: "photo")
                    })
                }
                .sheet(isPresented: $vm.showCameraSheet) {
                    ImagePicker(sourceType: vm.sourceType, selectedImage: $vm.selectedImage)
                        .ignoresSafeArea()
                }
                .alert("Error", isPresented: $vm.hasError, presenting: vm.errorMessage, actions: { errorMessage in
                }, message: { errorMessage in
                    Text(errorMessage)
                })
                
                Spacer()
            }
            .padding(.top, 50)
            .navigationTitle("Add Image")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: CancelButton, trailing: SaveButton)
        }
    }
    
    var CancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var SaveButton: some View {
        Button("Save") {
            if vm.save() {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageView()
    }
}
