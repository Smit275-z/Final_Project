import Foundation

struct StorageManager {
    // MARK: - File paths
    static let tasksFile = "tasks.json"
    static let goalsFile = "goals.json"
    
    // MARK: - Saving (Generic for [T: Codable])
    static func save<T: Codable>(_ items: [T], to fileName: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(items)
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            try data.write(to: url)
        } catch {
            print("Error saving \(fileName): \(error.localizedDescription)")
        }
    }
    
    // MARK: - Loading
    static func load<T: Codable>(from fileName: String, as type: T.Type) -> [T] {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let items = try decoder.decode([T].self, from: data)
            return items
        } catch {
            print("Error loading \(fileName): \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Helper
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
