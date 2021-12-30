import SwiftUI


// wall view as separate view
struct WallView: View {
    
    @ObservedObject var store: EmojiArtDocumentStore
    
    let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                
                //iterate through all documents
                ForEach(store.documents, id: \.self) { document in
                    WallDocument(document: document)
                }
    
            }
            .padding()
        }
    }
    
    // linked wall document as zstack
    func WallDocument(document: EmojiArtDocumentViewModel) -> some View {
        NavigationLink(
            destination: EmojiArtDocumentView(document: document)
                .navigationTitle(store.name(for: document))
        ){
            ZStack(alignment: .bottom){
                //background (show gray rectangle if document has no backgroundImage)
                VStack {
                    if let background = document.backgroundImage {
                        Image(uiImage: background)
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                    } else {
                        Rectangle()
                            .fill(.gray)
                            .aspectRatio(1, contentMode: .fill)
                    }
                }
                //document name on top of background
                Text(store.name(for: document))
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .font(.caption2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.4))
            }
        }
    }
    
}



