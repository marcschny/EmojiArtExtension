import SwiftUI

// background color editor sheet
struct BackgroundColorEditor: View{
    
    @Binding var isPresented: Bool
    @Binding var chosenColor: Color
    @Binding var chosenOpacity: Double
    @ObservedObject var document: EmojiArtDocumentViewModel

    init(isPresented: Binding<Bool>, chosenColor: Binding<Color>, chosenOpacity: Binding<Double>, document: EmojiArtDocumentViewModel) {
        self._isPresented = isPresented
        self._chosenColor = chosenColor // Binding.init expects Binding
        self._chosenOpacity = chosenOpacity
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
                        chosenColor = newValue
                        print(newValue)
                    }
                //TODO: why opacity slider? ColorPicker already has one implemented!
                HStack {
                    Slider(value: $chosenOpacity)
                        .onChange(of: chosenOpacity) { newValue in
                            chosenOpacity = newValue
                        }
                }
            }
            
        }
    }
    
}
