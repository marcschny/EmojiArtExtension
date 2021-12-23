import SwiftUI
import Combine


struct TimeTracker: View{
    
    
    let timerPublisher = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
    let cancellable: AnyCancellable?
    let startDate: Date
    @State private var timeSpent: Double = EmojiArtModel().timer ?? 0
    
    init(){
        self.cancellable = timerPublisher.connect() as? AnyCancellable
        startDate = Date()
    }
    
    var body: some View{
        return HStack{
            Image(systemName: "timer")
            Text("\(String(format: "%.0f", timeSpent)) s")
        }.onReceive(timerPublisher){ newTime in
            timeSpent = newTime.timeIntervalSince(startDate)
        }
    }
    
    mutating func startTimeTracker(){
        print("Tracker started")
    }
    
    mutating func stopTimeTracker(){
        print("Tracker stopped")
    }
    
    
    
}
