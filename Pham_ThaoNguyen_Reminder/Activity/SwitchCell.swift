
import UIKit


class SwitchCell: UITableViewCell {

    @IBOutlet weak var switchOutlet: UISwitch!
    
    //assign allowNotification property when switch on and off (tableView cell)
    @IBAction func switchChanged(_ sender: Any) {
        if switchOutlet.isOn == true {
            chosenCategory.allowNotification = true
        } else {
            chosenCategory.allowNotification = false
        }
        Categories.saveToFile(array: arrayOfCategories)
        
    }
    

}
