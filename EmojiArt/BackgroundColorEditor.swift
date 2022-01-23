import SwiftUI

// background color editor sheet
struct BackgroundColorEditor: View{
    
    @Binding var isPresented: Bool
    @State var chosenColor: Color
    @State var chosenOpacity: Double
    @ObservedObject var document: EmojiArtDocumentViewModel

    init(isPresented: Binding<Bool>, chosenColor: Color, chosenOpacity: Double, document: EmojiArtDocumentViewModel) {
        self._isPresented = isPresented
        self.chosenColor = chosenColor // Binding.init expects Binding
        self.chosenOpacity = chosenOpacity
        self.document = document // ObservedObject.init from wrappedValue
    }
    
    var body: some View{
        VStack{
            ZStack {
                Text("Background Color Editor")
                    .font(.headline)
                    .padding()
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Done")
                            .padding()
                    }
                }
            }
            Form{
                ColorPicker("Background Color", selection: $chosenColor)
                    .onChange(of: chosenColor) { newValue in
                        document.backgroundColor = newValue
                    }
                HStack {
                    Slider(value: $chosenOpacity)
                        .onChange(of: chosenOpacity) { newValue in
                            document.backgroundOpacity = newValue
                        }
                }
            }
            
        }
    }
    
}
