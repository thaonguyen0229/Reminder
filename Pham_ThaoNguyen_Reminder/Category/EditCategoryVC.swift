

import UIKit

class EditCategoryVC: UIViewController, UITextViewDelegate {
    var imageInt = chosenCategory.imageInt
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func editButtonPressed(_ sender: Any) {
        if editButton.title(for: .normal)! == "Done" {
            chosenCategory.imageInt = imageInt
            switch textField.text!{
                case "":
                    chosenCategory.title = "No title"
                
                default:
                    chosenCategory.title = textField.text!
            }
            switch textView.text! {
                case "Description":
                    chosenCategory.description = nil
                default:
                    chosenCategory.description = textView.text!
            }
            Categories.saveToFile(array: arrayOfCategories)
            performSegue(withIdentifier: "unwindToActivityFromEdit", sender: self)
        }
        for button in buttons {
            button.isEnabled = true
        }
        textField.isEnabled = true
        textView.isEditable = true
        editButton.setTitle("Done", for: .normal)
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        //display the properties of chosen reminder
        if chosenCategory.imageInt != 10 {
            buttons[chosenCategory.imageInt].setImage(#imageLiteral(resourceName: "checkmark-for-verification"), for: .normal)
            
        }
        for button in buttons {
            button.isEnabled = false
        }
        textView.layer.cornerRadius = 5
        textView.text! = "Description"
        textView.textColor = UIColor.lightGray
        textView.returnKeyType = .done
        textView.delegate = self
        editButton.layer.cornerRadius = 8
        if let description = chosenCategory.description {
            textView.text! = description
            textView.textColor = UIColor.black
        }
        textField.text! = chosenCategory.title
        
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
