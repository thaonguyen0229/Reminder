
import UIKit

class AddCategoryVC: UIViewController,UITextViewDelegate {
    var imageInt = 10
    
    @IBOutlet var buttons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTV.layer.cornerRadius = 5
        descriptionTV.text! = "Description"
        descriptionTV.textColor = UIColor.lightGray
        descriptionTV.returnKeyType = .done
        descriptionTV.delegate = self
        addButton.layer.cornerRadius = 8
       
    }
    
    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var descriptionTV: UITextView!
   
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addButtonPressed(_ sender: Any) {
        //add a new reminder with properties assigned  using  textField and textView
        switch (titleTF.text!,descriptionTV.text!) {
        case ("","Description"):
            arrayOfCategories.append(Categories(title: "No title", description: nil))
        case ("",""):
            arrayOfCategories.append(Categories(title: "No title", description: nil))
        case ("",_):
            arrayOfCategories.append(Categories(title: "No title", description: descriptionTV.text!))
            
        case (_,"Description"):
            arrayOfCategories.append(Categories(title: titleTF.text!, description: nil))
        case (_,""):
            arrayOfCategories.append(Categories(title: titleTF.text!, description: nil))
        default:
            arrayOfCategories.append(Categories(title: titleTF.text!, description: descriptionTV.text!))
        }
        
        //assign new reminder to the icon if user chooses one  of the icons
        arrayOfCategories[arrayOfCategories.count - 1].imageInt = imageInt
        print(imageInt)
        print(arrayOfCategories[arrayOfCategories.count - 1].imageInt)
        Categories.saveToFile(array: arrayOfCategories)
    }
    
    
    //action for each icon buttons. The chosen icon will have a checkmark. If user selects icon with a checkmark: choose not to use an icon, checkmark is remove. Can only choose one icon for each reminder
    @IBAction func cakePressed(_ sender: UIButton) {
        imageInt = checkIcons(imageInt: 0, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
        
    }
    @IBAction func boxPressed(_ sender: UIButton) {
       imageInt = checkIcons(imageInt: 1, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
        
    }
    @IBAction func dogPressed(_ sender: UIButton) {
        imageInt = checkIcons(imageInt: 2, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
    }
    @IBAction func presentPressed(_ sender: UIButton) {
        imageInt = checkIcons(imageInt: 3, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
    }
    @IBAction func groceryPressed(_ sender: UIButton) {
       imageInt = checkIcons(imageInt: 4, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
    }
    @IBAction func homeworkPressed(_ sender: UIButton) {
        imageInt = checkIcons(imageInt: 5, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
    }
    @IBAction func microwavePressed(_ sender: UIButton) {
        imageInt = checkIcons(imageInt: 6, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
    }
    
    @IBAction func payPressed(_ sender: UIButton) {
        imageInt = checkIcons(imageInt: 7, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
    }
    @IBAction func travelPressed(_ sender: UIButton) {
        imageInt = checkIcons(imageInt: 8, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
    }
    @IBAction func exercisePressed(_ sender: UIButton) {
        imageInt = checkIcons(imageInt: 9, currentImageInt: imageInt)
        for button2 in buttons {
            button2.setImage(nil, for: .normal)
        }
        if imageInt != 10 {
            sender.setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
        }
    }
    
    
    
    //UITextViewDelegate: create  placeholder for UITextView
    //execute when user starts editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text! == "Description" {
            textView.text! = ""
            textView.textColor = UIColor.black
        }
    }
    
    //close the keyboard when user presses return key
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     if text == "\n" {
     textView.resignFirstResponder()
     }
     return true
     }
    
    //display placeholder if the textview is empty
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text! == "" {
            textView.text! = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    //check the icon that user current chooses. If the current icon and updated icon are the  same, users chooses not to user icon. Otherwise, icon is  updated.
    func checkIcons(imageInt: Int, currentImageInt: Int) -> Int{
        var updatedImageInt = 10
        guard currentImageInt != imageInt else {
            return updatedImageInt
        }
        updatedImageInt = imageInt
        return updatedImageInt
    }
    

}
