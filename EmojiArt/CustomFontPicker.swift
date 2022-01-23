import UIKit
import SwiftUI

// CustomFontPicker not working properly
// only works on new documents added
// TODO: try to use an Env variable to globally change font
struct CustomFontPicker: UIViewControllerRepresentable {
    @Binding var font: UIFontDescriptor?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> CustomFontPicker.Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIFontPickerViewController {
        let picker = UIFontPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIFontPickerViewController, context: Context) {
    }
    
    class Coordinator: NSObject, UIFontPickerViewControllerDelegate {
        var parent: CustomFontPicker
        
        init(_ parent: CustomFontPicker) {
            self.parent = parent
        }
        
        func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
        }

        func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
            parent.font = viewController.selectedFontDescriptor
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

