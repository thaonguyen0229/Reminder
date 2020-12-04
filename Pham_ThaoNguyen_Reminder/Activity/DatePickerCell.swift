
import UIKit
//delegate
protocol DatePickerCellDelegate {
    func didChangeDate(date: Date)
}

//create action for date picker
class DatePickerCell: UITableViewCell {

    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    var delegate: DatePickerCellDelegate?

    @IBAction func pickerAction(_ sender: Any) {
        delegate?.didChangeDate(date: datePickerOutlet.date)
    }
    
    
    
}
