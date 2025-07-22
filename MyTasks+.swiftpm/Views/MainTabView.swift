import SwiftUI

struct MainTabView: View {
    
    @State private var tasks: [Task] = []
    
    var body: some View {
        TabView {
            TaskListView(tasks: $tasks)
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Tasks")
                }
            
            WeeklyGoalTrackerView()
                .tabItem {
                    Image(systemName: "flag")
                    Text("Weekly Goals")
                }
            
            StatsView(tasks: tasks)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Stats")
                }
        }
    }
}
