import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var hasError: Bool = false
    @Published var errorMessage: String? {
        didSet {
            hasError = errorMessage != nil
        }
    }
}
