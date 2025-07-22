import SwiftUI

struct MainTabView: View {
    
    @State private var tasks: [Task] = StorageManager.load(from: StorageManager.tasksFile, as: Task.self)
    @State private var goals: [Goal] = StorageManager.load(from: StorageManager.goalsFile, as: Goal.self)
    
    var body: some View {
            TabView {
                TaskListView(tasks: $tasks)
                    .tabItem { Image(systemName: "checklist"); Text("Tasks") }
                
                WeeklyGoalTrackerView(goals: $goals)
                    .tabItem { Image(systemName: "flag"); Text("Weekly Goals") }
                
                StatsView(tasks: tasks)
                    .tabItem { Image(systemName: "chart.bar"); Text("Stats") }
            }
            // Save data whenever tasks or goals change!
            .onChange(of: tasks) { newTasks in
                StorageManager.save(newTasks, to: StorageManager.tasksFile)
            }
            .onChange(of: goals) { newGoals in
                StorageManager.save(newGoals, to: StorageManager.goalsFile)
            }
        }
    }
