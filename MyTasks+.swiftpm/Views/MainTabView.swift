import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            TaskListView()
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Tasks")
                }

            WeeklyGoalTrackerView()
                .tabItem {
                    Image(systemName: "flag")
                    Text("Weekly Goals")
                }
        }
    }
}
