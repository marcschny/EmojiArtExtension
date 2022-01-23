import SwiftUI

struct EditableText: View {
    var text: String = ""
    var isEditing: Bool
    var onChanged: (String) -> Void

    @State private var editableText: String = ""
    @State private var customFont: String

    
    init(_ text: String, isEditing: Bool, onChanged: @escaping (String) -> Void, customFont: String) {
        self.text = text
        self.isEditing = isEditing
        self.onChanged = onChanged
        self.customFont = customFont
    }


    var body: some View {
        Group {
            if isEditing {
                TextField(text, text: $editableText)
                    .onChange(of: editableText) { text in
                        onChanged(editableText)
                    }
            } else {
                Text(text).font(.custom(customFont, size: 18))
            }
        }
        .onAppear { self.editableText = self.text }
    }
}
