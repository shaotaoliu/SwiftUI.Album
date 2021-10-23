import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("album.columns") var columns: Int = 3
    @ObservedObject private var vm = SettingViewModel()
    @FocusState var focusColumns
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Text("Columns")
                        
                        Spacer()
                        
                        TextField("", text: $vm.input)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 130)
                            .keyboardType(.numberPad)
                            .focused($focusColumns)
                        
                        Button(action: {
                            vm.clear()
                            focusColumns = true
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .font(.title3)
                        })
                            .buttonStyle(.borderless)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CancelButton, trailing: SaveButton)
        }
    }
    
    var SaveButton: some View {
        Button("Save") {
            if vm.save(required: true, max: 6, min: 1) {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .alert("Error", isPresented: $vm.hasError, presenting: vm.errorMessage, actions: { error in
        }, message: { error in
            Text(error)
        })
    }
    
    var CancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
