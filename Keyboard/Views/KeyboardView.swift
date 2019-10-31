import UIKit
import Firebase

protocol KeyboardViewDelegate: class {
    func insertCharacter(_ newCharacter: String)
    func deleteCharacterBeforeCursor()
    func characterBeforeCursor() -> String?
}

class KeyboardView: UIView {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    
    weak var delegate: KeyboardViewDelegate?
    
    
    
    var signalCache: [KeyboardData.Signal] = [] {
        didSet {
            var text = ""
            if signalCache.count > 0 {
                text = signalCache.reduce("") {
                    return $0 + $1.rawValue
                }
                text += " = \(cacheLetter)"
            }
        }
    }
    
    var cacheLetter: String {
        return KeyboardData.letter(fromSignals: signalCache) ?? "?"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setColorScheme(.dark)
        setNextKeyboardVisible(true)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setColorScheme(.light)
        setNextKeyboardVisible(true)
    }
    
    func setNextKeyboardVisible(_ visible: Bool) {
        //    spaceButtonToNextKeyboardConstraint.isActive = visible
        //    spaceButtonToParentConstraint.isActive = !visible
        nextKeyboardButton.isHidden = !visible
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        let colorScheme = Colors(colorScheme: colorScheme)
        backgroundColor = colorScheme.backgroundColor
        
        for view in subviews {
            if let button = view as? KeyboardButton {
                button.setTitleColor(colorScheme.buttonTextColor, for: [])
                button.tintColor = colorScheme.buttonTextColor
                
                if button == nextKeyboardButton || button == deleteButton {
                    button.defaultBackgroundColor = colorScheme.buttonHighlightColor
                    button.highlightBackgroundColor = colorScheme.buttonBackgroundColor
                } else {
                    button.defaultBackgroundColor = colorScheme.buttonBackgroundColor
                    button.highlightBackgroundColor = colorScheme.buttonHighlightColor
                }
            }
        }
    }
    
    @IBAction func pressLetter(_ sender: UIButton) {
        delegate!.insertCharacter(sender.currentTitle!)
        print(sender.currentTitle!)
    }
    
    
    @IBAction func getName(_ sender: UIButton) {
        databaseRef().child("user").observeSingleEvent(of: .value, with: { (snapshot) in
            self.delegate!.insertCharacter("123")
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            print(username + "123")
            self.delegate!.insertCharacter(username)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}

extension KeyboardView {
    
    @IBAction func deletePressed() {
        delegate?.deleteCharacterBeforeCursor()
    }
    
    @IBAction func spacePressed() {
        delegate?.insertCharacter(" ")
    }
    
    func databaseRef() -> DatabaseReference {
        let ref: DatabaseReference = Database.database().reference()
        return ref
    }
    
}

private extension KeyboardView {
    func addSignal(_ signal: KeyboardData.Signal) {
        delegate?.insertCharacter(cacheLetter)
    }
}
