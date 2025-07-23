import SwiftUI

// View that displays the list of tasks, allows marking complete, editing, adding, and deleting
struct TaskListView: View {
    @Binding var tasks: [Task]
    @State private var showingAddTask = false
    @State private var editingTask: Task? = nil  // Tracks which task is being edited
    @State private var taskToDelete: IndexSet?   // Tracks which task is about to be deleted
    @State private var showDeleteAlert = false  // Controls showing the delete confirmation alert

    var body: some View {
        NavigationView {
            List {
                ForEach($tasks) { $task in  // ForEach with binding allows direct editing of each task in the array
                    HStack {
                        Button(action: { task.isCompleted.toggle() }) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                        }
                        Text(task.title)
                            .onTapGesture {
                                editingTask = task
                            }
                        Spacer()
                    }
                }
                .onDelete { offsets in    // Swipe to delete and shows confirmation alert
                    taskToDelete = offsets
                    showDeleteAlert = true
                }
            }
            .navigationTitle("MyTasks+")  
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")  // Plus button to add new task
                    }
                }
            }
            // Sheet for editing a task
            .sheet(item: $editingTask) { taskToEdit in
                EditTaskView(task: taskToEdit, tasks: $tasks, dismiss: { editingTask = nil })
            }
            // Sheet for adding a new task
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(tasks: $tasks)
            }
            // Alert for confirming task deletion
            .alert("Delete Task?", isPresented: $showDeleteAlert, actions: {
                Button("Delete", role: .destructive) {
                    if let offsets = taskToDelete {
                        tasks.remove(atOffsets: offsets)
                    }
                    taskToDelete = nil
                }
                Button("Cancel", role: .cancel) {
                    taskToDelete = nil
                }
            }, message: {
                Text("Are you sure you want to delete this task?")
            })
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
