
import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let whitishBlue = UIColor.blue.withAlphaComponent(0.3)
        let whitishPurple = UIColor.purple.withAlphaComponent(0.4)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, whitishBlue.cgColor, whitishPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
    }
}

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    @IBOutlet weak var displayLabel: UILabel!
    var firstTyping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var actionSign: String = ""
    var dotIsHere = false
    var currentInput: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayLabel.text = "\(valueArray[0])"
            } else {
                displayLabel.text = "\(newValue)"
            }
            firstTyping = false
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        if firstTyping {
            if (displayLabel.text?.characters.count)! < 10 {
                displayLabel.text = displayLabel.text! + number
            }
        }
        else {
                displayLabel.text = number
                firstTyping = true
        }
    }
    
    @IBAction func numberActionPressed(_ sender: UIButton) {
        firstOperand = currentInput
        actionSign = sender.currentTitle!
        firstTyping = false
        dotIsHere = false
    }
    
    func  operandsAction(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        firstTyping = false
    }
    
    @IBAction func equality(_ sender: UIButton) {
        if firstTyping {
            secondOperand = currentInput
        }
        dotIsHere = false
        switch actionSign {
        case "+":
            operandsAction{$0 + $1}
        case "-":
            operandsAction{$0 - $1}
        case "÷":
            operandsAction{$0 / $1}
        case "×":
            operandsAction{$0 * $1}
        default:
            break
        }
    }
    
    @IBAction func plusMinus(_ sender: UIButton) {
        if displayLabel.text != "0" {
            currentInput = -currentInput
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayLabel.text = "0"
        firstTyping = false
        actionSign = ""
        dotIsHere = false
    }
    
    @IBAction func procent(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput/100
        } else {
            secondOperand = firstOperand * currentInput / 100
            firstTyping = false
        }
    }
    
    @IBAction func dot(_ sender: UIButton) {
        if firstTyping && !dotIsHere {
            displayLabel.text = displayLabel.text! + "."
            dotIsHere = true
        } else if !firstTyping && !dotIsHere {
            displayLabel.text = "0."
            firstTyping = true
            dotIsHere = true
        }
    }
}

