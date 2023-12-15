import Foundation
import UIKit

class UIConstructor {
    static func createView() -> UIView {
        return {
            let view = UIView()
            return view
        }()
    }
    
    static func createLabel(text: String, textColor: UIColor = UIColor.white, textAlignment: NSTextAlignment = .center, font: UIFont = UIFont.boldSystemFont(ofSize: 16), tag: Int?) -> UILabel {
        return {
            let label = UILabel()
            label.text = text
            label.textColor = textColor
            label.textAlignment = textAlignment
            label.font = font
            if(tag != nil) {
                label.tag = tag! 
            }
            return label
        }()
    }
    
    static func createButton(title: String, textColor: UIColor = UIColor.white, font: UIFont = UIFont.boldSystemFont(ofSize: 18), configuration: UIButton.Configuration = .filled(), tag: Int?) -> UIButton {
        return {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            if(tag != nil) {
                button.tag = tag!
            }
            button.titleLabel?.font = font
            button.configuration = configuration
            
            
            return button
        }()
    }
}
