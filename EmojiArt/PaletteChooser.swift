import SwiftUI

struct PaletteChooser: View {
    @ObservedObject var document: EmojiArtDocumentViewModel
    @Binding var chosenPalette: String

    var body: some View {
        HStack {
            Button(action: {
                chosenPalette = document.palette(before: chosenPalette)
            }) {
                Image(systemName: "arrow.left")
            }
            Button(action: {
                chosenPalette = document.palette(after: chosenPalette)
            }) {
                Image(systemName: "arrow.right")
            }
            Text(document.paletteNames[chosenPalette] ?? "")
        }
    }
}
