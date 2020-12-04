
import UIKit

class AddActivityVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButtonPressed(_ sender: Any) {
        //add new activity to to-do list unwind segue to the previous vc (preform segue that unwind the previous segue)
        switch textField.text! {
        case "":
            textField.shake()
        default:
            chosenCategory.arrayOfActivities.append(Activity(title: textField.text!))
            Categories.saveToFile(array: arrayOfCategories)
         performSegue(withIdentifier: "unwindToActivity", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 8
    }
    

    

}
