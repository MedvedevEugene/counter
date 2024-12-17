import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var historyTextView: UITextView!
    
    var counter = 0 {
        didSet {
            updateCounterLabel()
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Изначальное состояние
        counter = 0
        historyTextView.text = "История изменений:"
        historyTextView.isEditable = false
    }
    
    func updateCounterLabel() {
        counterLabel.text = "Значение счётчика: \(counter)"
    }
    
    func appendToHistory(_ text: String) {
        let currentDate = dateFormatter.string(from: Date())
        let entry = "\n\(currentDate): \(text)"
        historyTextView.text += entry
        
        // Прокрутка к низу истории
        let bottom = NSMakeRange(historyTextView.text.count - 1, 1)
        historyTextView.scrollRangeToVisible(bottom)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        counter += 1
        appendToHistory("значение изменено на +1")
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        if counter > 0 {
            counter -= 1
            appendToHistory("значение изменено на -1")
        } else {
            appendToHistory("попытка уменьшить значение счётчика ниже 0")
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        counter = 0
        appendToHistory("значение сброшено")
    }
}
