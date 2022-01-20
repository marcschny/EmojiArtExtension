import SwiftUI
import Combine


struct TimeTracker: View{
    
    @ObservedObject var document: EmojiArtDocumentViewModel
    
    init(document: EmojiArtDocumentViewModel){
        self.document = document
    }
    
    var body: some View{
        return HStack{
            Image(systemName: "timer")
            Text("\(String(format: "%.0f", document.timer)) s")
        }
    }
    
    
    
}
