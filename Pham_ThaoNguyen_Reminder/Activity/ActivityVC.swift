

import UIKit

class ActivityVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var isOpened = false
    
    //return number of sections
    func numberOfSections(in tableView: UITableView) ->
        Int {
            return 4
    }
    //each section corresponds to each property of the reminder
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Notification"
        case 2:
            return "Description"
        case 3:
            return "To-do"
        default:
            return nil
        }
    }
    
    //return number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if isOpened == false {
                return 1
            } else {
                return 2
            }
        case 2:
            return 1
        default:
            return chosenCategory.arrayOfActivities.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //custom cell for date picker(choose due date on which notification is sent)
        guard [indexPath.section,indexPath.row] != [1,1] else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") as! DatePickerCell
            cell2.delegate = self
            if chosenCategory.allowNotification == true {
                cell2.datePickerOutlet.date = chosenCategory.time
            }
            return cell2
        }
        
        //custom cell with a switch to turn on notification
        guard indexPath.section != 0 else {
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! SwitchCell
            if chosenCategory.allowNotification == true {
                cell3.switchOutlet.isOn = true
            } else {
                cell3.switchOutlet.isOn = false
            }
            return cell3
        }
        
        //cell: basic(style), checkmark for to-do list
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        switch (indexPath.section, indexPath.row) {
        case (1,0):
            cell.accessoryType = .detailButton
            cell.textLabel!.text = "Time"
        case (2,_):
            cell.accessoryType = .detailButton
            if let description = chosenCategory.description {
                
                cell.textLabel!.text = description
            } else {
                
                cell.textLabel!.text = "No description"
            }
            
        default:
            cell.textLabel!.text = chosenCategory.arrayOfActivities[indexPath.row].title
            if chosenCategory.arrayOfActivities[indexPath.row].checkmark == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    
    
    
    //allow user to delete rows and to-dos
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //remove activity from the reminder when deleting rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == 3 {
            chosenCategory.arrayOfActivities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Categories.saveToFile(array: arrayOfCategories)
        }
    }
    
    //segue to vc that allows editing properties when selecting description cell
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 2 {
            performSegue(withIdentifier: "ToEditCategory", sender: nil)
        }
        return indexPath
    }
    
    //open the date picker when selecting Time row and checkmark activity (select activity)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            guard indexPath.row == 0 else {
                return
            }
            if isOpened == true {
                isOpened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                isOpened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        case 3:
            if chosenCategory.arrayOfActivities[indexPath.row].checkmark == false {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                chosenCategory.arrayOfActivities[indexPath.row].checkmark = true
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                chosenCategory.arrayOfActivities[indexPath.row].checkmark = false
            }
            Categories.saveToFile(array: arrayOfCategories)
        default:
            print(0)
            print(chosenCategory.allowNotification)
        }
        
        
    }
    
    
    
    
    @IBAction func unwindToActivity(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isOpened = false
        tableView.reloadData()
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



//DatePickerCellDelegate: assign due dates
extension ActivityVC: DatePickerCellDelegate {
    func didChangeDate(date: Date) {
        chosenCategory.time = date
        Categories.saveToFile(array: arrayOfCategories)
        print(chosenCategory.time)
    }
}

