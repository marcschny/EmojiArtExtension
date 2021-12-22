import SwiftUI


struct TimeTracker: View{
    
    var time: Int   //in seconds
    
    var body: some View{
        return HStack{
            Image(systemName: "timer")
            Text("\(time) s")
        }
    }
    
    func startTimeTracker(){
        print("Tracker started")
    }
    
    func stopTimeTracker(){
        print("Tracker stopped")
    }
    
    
    
}
