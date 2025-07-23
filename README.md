MyTasks+ — README

MyTasks+ is a simple personal productivity app built using SwiftUI.
It allows users to manage daily tasks with a clean and user-friendly interface.

-----------------------------------------------------------------------------------------------------------------------------------

Features Implemented
	•	Add Tasks: Users can add new tasks by entering a title and optional notes.
	•	Task List: All added tasks are displayed in a list, with completed tasks shown with a checkmark.
    •   Goal List: Here all the goals are displayed with a brief overview.
    •   Status:    Here you can see the percentage of completed task form the task list.
	
SwiftUI Concepts:
	•	Uses @State for managing UI state (list of tasks, add task sheet visibility).
	•	Uses @Binding for passing tasks array to subviews (AddTaskView).
	•	Uses NavigationView for navigation and modal sheet presentation.
	•	Uses Form, TextField, and ToolbarItem for input and actions.
	•	Extensible Structure:
	•	The app is structured for easy expansion to include more features, such as editing tasks, weekly goals, stats, and persistent data storage.

-----------------------------------------------------------------------------------------------------------------------------------

How to Use
	•	Tap the ”+” button to open the Add Task sheet.
	•	Enter a task title (required) and notes (optional), then tap Save.
	•	View your tasks in the main list. Completed tasks are indicated with a green checkmark.
    •   User can Add Goals and status of the goal as well
    •   Under Status user can keep track of the progress   

-----------------------------------------------------------------------------------------------------------------------------------

Files Overview
	•	MyTasksPlusApp.swift - App entry point.
	•	Models/ -  model definition.
	•	Views/ - Contains all the UI files.
	•	Views/MainTabView.swift - Main UI.

