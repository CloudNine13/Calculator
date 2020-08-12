//
//  HomeViewController.swift
//  Calculator
//
//  Created by Vitcord23 on 11/08/2020.
//  Copyright © 2020 IgorDzichkovskii. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    // Result
    @IBOutlet weak var resultLabel: UILabel!
    
    // Numbers
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    // Operators
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorPlus: UIButton!
    @IBOutlet weak var operatorMinus: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    
    
    // MARK: - Variables
    
    private var total: Double = 0
    private var temp: Double = 0
    private var operating: Bool = false
    private var decimal: Bool = false
    private var operation: OperationType = .none
    
    
    // MARK: - Constants
    
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kMaxValue: Double = 999999999
    private let kMinValue: Double = 0.00000001
    
    
    // MARK: - Formatters
    
    private var auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    private enum OperationType {
        case none, plus, minus, multiply, divide, percent
    }
    
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        
        operatorAC.round()
        operatorPlusMinus.round()
        operatorPercent.round()
        operatorResult.round()
        operatorPlus.round()
        operatorMinus.round()
        operatorMultiplication.round()
        operatorDivision.round()
        
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        
    }
    
    // MARK: - Button Actions
    
    @IBAction func operatorACAction(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
        temp = temp * (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        sender.shine()
    }

    @IBAction func operatorPercentAction(_ sender: UIButton) {
        
        if operation != .percent {
            result()
        }
        operating = true
        operation = .percent
        result()
        
        sender.shine()
    }
    
    @IBAction func operatorResultAction(_ sender: UIButton) {
        
        result()
        
        sender.shine()
    }
    
    @IBAction func operatorPlusAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .plus
        sender.shine()
    }
    
    @IBAction func operatorMinusAcion(_ sender: UIButton) {
        result()
        operating = true
        operation = .minus
        sender.shine()
    }
    
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .multiply
        sender.shine()
    }
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .divide
        sender.shine()
    }
    
    @IBAction func NumberDecimalAction(_ sender: UIButton) {
        let currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        resultLabel.text = resultLabel.text! + kDecimalSeparator
        decimal = true
        
        sender.shine()
    }
 
    @IBAction func numberAction(_ sender: UIButton) {
        sender.shine()
    }
    
    
    // MARK: - Private fucntions
    
    private func clear(){
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        } else {
            total = 0
            result()
        }
    }
    
    private func result() {
        switch operation {
            
        case .none:
            break
            
        case .plus:
            total = total + temp
            break
            
        case .minus:
            total = total - temp
            break
            
        case .multiply:
            total = total * temp
            break
            
        case .divide:
            total = total / temp
            break
            
        case .percent:
            temp = temp / 100
            total = temp
            break
            
        }
        
        if total <= kMaxValue || total >= kMinValue {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
    }
}
