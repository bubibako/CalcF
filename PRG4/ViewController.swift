//
//  ViewController.swift
//  PRG4
//
//  Created by Arthur Trampnau on 08/10/24.
//

import UIKit

enum Calculation: Error {
    case divisionByZero
}

enum Operation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    
    func calculate(_ number1: Double, _ number2: Double) throws -> Double {
        switch self {
        case .add:
            return number1 + number2
        case .subtract:
            return number1 - number2
        case .multiply:
            return number1 * number2
        case .divide:
            if number2 == 0 { throw Calculation.divisionByZero }
            return number1 / number2
        }
    }
}

enum CalculateHistory {
    case number (Double)
    case operation (Operation)
}

class ViewController: UIViewController {
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        guard let ButtonText = sender.currentTitle
        else {
            return
        }
        
        if ButtonText == "." && Label.text?.contains(".") == true  {
            return
        }
        if Label.text == "0" {
            Label.text = ButtonText
        }
        else {
            Label.text?.append(ButtonText)
        }
    }
    
    @IBAction func OperationButtonPressed(_ sender: UIButton) {
        guard
            let ButtonText = sender.currentTitle,
            let buttonOperation = Operation(rawValue: ButtonText)
        else {
            return
        }
        
        guard
            let LabelText = Label.text,
            let LabelNumber = numberFormatter.number(from: LabelText)?.doubleValue
        else {
            return
        }
        
        CalculateHistory.append(.number(LabelNumber))
        CalculateHistory.append(.operation(buttonOperation))
        
        resetLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func ClearButtonPressed() {
        CalculateHistory.removeAll()
        resetLabel()
    }
    
    @IBAction func CalculateButtonPressed() {
        guard
            let LabelText = Label.text,
            let LabelNumber = numberFormatter.number(from: LabelText)?.doubleValue
        else {
            return
        }
        CalculateHistory.append(.number(LabelNumber))
        
        do {
            let result = try calculate()
            Label.text = numberFormatter.string(from: NSNumber(value: result))
        }
        catch {
            Label.text = "error"
        }
        CalculateHistory.removeAll()
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard segue.identifier == "History", let HistoryVC = segue.destination as? HistoryViewController else { return }
        HistoryVC.result = Label.text
        
    }
    
    @IBOutlet weak var Label: UILabel!
    
    var CalculateHistory: [CalculateHistory] = []
    
    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            resetLabel()
        }
        func resetLabel() {
            Label.text = "0"
        }

    
    func calculate() throws -> Double {
        guard case .number(let firstNumber) = CalculateHistory[0] else {
            return 0
        }
        var currentResult = firstNumber
        
        for index in stride(from: 1, to: CalculateHistory.count - 1, by: 2) {
            guard
                case .operation(let operation) = CalculateHistory[index],
                case .number(let number) = CalculateHistory[index + 1]
            else {
                break
            }
            
            currentResult = try operation.calculate(currentResult, number)
        }
        
        return currentResult
    }
}
