

import Foundation
import UserNotifications
import UIKit

class Categories: Codable {
    //property
    var title: String
    var description: String?
    var arrayOfActivities: [Activity] = []
    var allowNotification = false
    var time = Date()
    var imageInt = 10
    
    //initializer
    init(title: String, description: String?) {
        self.title = title
        self.description = description
    }
    
    
    //Codable: properties to save data
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("categories_saved").appendingPathExtension("plist")
    static let propertyListEncoder = PropertyListEncoder()
    
    
    //Codable: function used to save an array of categories(reminders)
    static func saveToFile(array: [Categories]) {
        var array2: [[Activity]] = []
        for index in array {
            array2.append(index.arrayOfActivities)
        }
        Activity.saveToFile(array: array2)
        
        let encodedCategories = try? propertyListEncoder.encode(array)
        try? encodedCategories?.write(to: archiveURL, options: .noFileProtection)
    }
    
    //Codable: properties to load the saved data
    static let propertyListDecoder = PropertyListDecoder()
    
    //Codable: function called when loading the saved data
    static func loadFromFile() {
        let allActivities = Activity.loadFromFile()
        
        if let retrievedCategoriesData = try? Data(contentsOf: archiveURL), let decodedCategories = try? propertyListDecoder.decode(Array<Categories>.self, from: retrievedCategoriesData) {
            arrayOfCategories = decodedCategories
            
            for index in 0..<arrayOfCategories.count {
                arrayOfCategories[index].arrayOfActivities = allActivities[index]
            }
        }
    }
    
}


var chosenCategory: Categories = Categories(title: "", description: nil)
var arrayOfCategories: [Categories] = []

//create notification for each reminder. called when user quits app
func sendNotification(category: Categories) {
    if category.allowNotification == true {
        let content = UNMutableNotificationContent()
        content.title = category.title
        content.badge = 1
        content.sound = UNNotificationSound.default
        if let description = category.description {
            content.body = description
        }
        
        
        var dateComps = DateComponents()
        let calendar = Calendar.current
        dateComps.year = calendar.component(.year, from: category.time)
        dateComps.month = calendar.component(.month, from: category.time)
        dateComps.day = calendar.component(.day, from: category.time)
        dateComps.hour = calendar.component(.hour, from: category.time)
        dateComps.minute = calendar.component(.minute, from: category.time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComps, repeats: false)
        
        let request = UNNotificationRequest(identifier: ":)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
   
}

//images for icons
let images: [UIImage] = [#imageLiteral(resourceName: "birthday-cake"), #imageLiteral(resourceName: "box"), #imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "giftbox"), #imageLiteral(resourceName: "groceries"), #imageLiteral(resourceName: "homework"), #imageLiteral(resourceName: "microwave"), #imageLiteral(resourceName: "pay-per-click"), #imageLiteral(resourceName: "travel"), #imageLiteral(resourceName: "weightlifter")]

