
import Foundation


struct Activity: Codable {
    //property
    var title: String
    var checkmark = false
    
    //initlizer
    init(title: String) {
        self.title = title
    }
    
    //Codable: properties to save data
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("activity_saved").appendingPathExtension("plistt")
    static let propertyListEncoder = PropertyListEncoder()
    
    //Codable: function used to save an array of arrays of activities (an array of activities corresponds to one category)
    static func saveToFile(array: [[Activity]]) {
        let encodedActivity = try? propertyListEncoder.encode(array)
        try? encodedActivity?.write(to: archiveURL, options: .noFileProtection)
    }
    
    //Codable: properties to load the saved data
    static let propertyListDecoder = PropertyListDecoder()
    
    //Codable: function called when loading the saved data
    static func loadFromFile() -> [[Activity]]{
        if let retrievedActivityData = try? Data(contentsOf: archiveURL), let decodedActivity = try? propertyListDecoder.decode(Array<[Activity]>.self, from: retrievedActivityData) {
            return decodedActivity
        } else {
            return []
            
        }
    }
}


