
import UIKit
import UserNotifications


class CategoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //return number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCategories.count
    }
    
    //display rows in tableview. Each row corresponds to one reminder
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel!.text = arrayOfCategories[indexPath.row].title
        if arrayOfCategories[indexPath.row].imageInt != 10 {
           cell.imageView?.image = images[arrayOfCategories[indexPath.row].imageInt]
        } else {
            cell.imageView?.image = nil
        }
        return cell
    }
    
    //segue to vc that indicates all properties of a chosen category
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        chosenCategory = arrayOfCategories[indexPath.row]
        performSegue(withIdentifier: "ToActivity", sender: nil)
        return indexPath
    }
    
    //allow user to delete rows and reminder
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //remove category from the array when deleting rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayOfCategories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Categories.saveToFile(array: arrayOfCategories)
        }
    }
    
    
    //change navigation item when chosing a category
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToActivity" {
            segue.destination.navigationItem.title = chosenCategory.title
        }
    }
    
    
    @IBAction func sortButtonPressed(_ sender: Any) {
        sorting()
        tableView.reloadData()
    }
    
    @IBAction func unwindToCategoryVC(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //sorting algorithm
    func sorting() {
        var haveNoti: [Categories] = []
        var noNoti: [Categories] = []
        
        //create one array of categories with notification and one array of categories without notification
        for index in arrayOfCategories {
            if index.allowNotification == true {
                haveNoti.append(index)
            } else {
                noNoti.append(index)
            }
        }
        //use merge sort for array having notification
        haveNoti = splittingSection(unsortedArray: haveNoti)
        arrayOfCategories = haveNoti + noNoti
    }
    //merge sort: split array
    func splittingSection(unsortedArray: [Categories]) -> [Categories]{
        guard unsortedArray.count > 1 else {
            return unsortedArray
        }
        let middleIndex = unsortedArray.count/2
        let leftArray = Array(unsortedArray[0..<middleIndex])
        let rightArray = Array(unsortedArray[middleIndex..<unsortedArray.count])
        return mergeSection(leftArray: splittingSection(unsortedArray: leftArray), rightArray: splittingSection(unsortedArray: rightArray))
    }
    
    //merge sort: sort in order of increasing in dates
    func mergeSection(leftArray: [Categories], rightArray: [Categories]) -> [Categories] {
        var sortedArray: [Categories] = []
        var leftt = leftArray
        var rightt = rightArray
        while leftt.count > 0 && rightt.count > 0 {
            if leftt.first!.time < rightt.first!.time {
                sortedArray.append(leftt.removeFirst())
            } else {
                sortedArray.append(rightt.removeFirst())
            }
        }
        return sortedArray + leftt + rightt
    }
    
}

