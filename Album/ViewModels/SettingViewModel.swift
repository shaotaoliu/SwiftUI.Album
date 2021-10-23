import Foundation
import SwiftUI

class SettingViewModel: ViewModel {
    
    @AppStorage("album.columns") var columns: Int = 3
    
    @Published var input: String = "" {
        didSet {
            let numberOnly = input.filter { $0.isNumber }
            if input != numberOnly {
                input = numberOnly
            }
        }
    }
    
    override init() {
        super.init()
        input = String(columns)
    }
    
    func clear() {
        input = ""
        errorMessage = nil
    }
    
    func save(required: Bool = true, max: Int? = nil, min: Int? = nil) -> Bool {
        
        if required, input.isEmpty {
            errorMessage = "Value cannot be empty"
            return false
        }
        
        guard let intValue = Int(input) else {
            errorMessage = "Invalid value"
            return false
        }
        
        if let max = max, intValue > max {
            errorMessage = "Value cannot be greater than \(max)"
            return false
        }
        
        if let min = min, intValue < min {
            errorMessage = "Value cannot be less than \(min)"
            return false
        }
        
        columns = intValue
        return true
    }
}
