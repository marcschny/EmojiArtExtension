import SwiftUI

struct EmojiArtDocumentChooser: View {
    @ObservedObject var store: EmojiArtDocumentStore
    @State private var editMode = EditMode.inactive

    private var initialDetailView: some View {
        let document = store.documents.first ?? EmojiArtDocumentViewModel()
        return EmojiArtDocumentView(document: document)
            .navigationTitle(store.name(for: document))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(store.documents) { document in
                    let emojiArtDocumentView = EmojiArtDocumentView(document: document)
                        .navigationTitle(store.name(for: document))
                    NavigationLink(destination: emojiArtDocumentView) {
                        EditableText(store.name(for: document), isEditing: editMode.isEditing, onChanged: { name in
                            store.setName(name, for: document)
                        })
                    }
                }
                .onDelete { indexSet in
                    indexSet
                        .map { store.documents[$0] }
                        .forEach { store.removeDocument($0) }
                }
            }
            .navigationBarTitle(store.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        store.addDocument()
                    }) {
                        Image(systemName: "plus").imageScale(.large)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink(destination: openWallView()){
                        Image(systemName: "square.grid.2x2.fill").imageScale(.large)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)

            createInitialDetailView()
        }
    }

    // create new document
    private func createInitialDetailView() -> some View {
        let document = store.documents.first ?? store.addDocument()
        return EmojiArtDocumentView(document: document)
            .navigationTitle(store.name(for: document))
    }
    
    // navigate to wall view
    private func openWallView() -> some View {
        return WallView(store: store)
            .navigationTitle("Wall View")
    }
}
