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
            
            //get formatted time
            let (h,m,s) = timeFormatter(time: document.timer)
            
            //only show necessarry time attributes
            if(timeFormatter(time: document.timer).0 != 0){
                Text("\(h)h \(m)m \(s)s")
            }else if(timeFormatter(time: document.timer).1 != 0){
                Text("\(m)m \(s)s")
            }else{
                Text("\(s)s")
            }
        }
    }
    
    //format time (ss -> hh:mm:ss)
    private func timeFormatter(time: Double) -> (Int, Int, Int){
        let hours: Int = Int(time) / 3600
        let minutes: Int = (Int(time) % 3600) / 60
        let seconds: Int = (Int(time) % 3600) % 60
        return (hours, minutes, seconds)
    }
    
    
    
}
