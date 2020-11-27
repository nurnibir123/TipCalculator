//
//  ViewController.swift
//  tip
//
//  Created by Nur Nibir on 11/8/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var partySizeTextField: UILabel!
    @IBOutlet weak var perPersonLabel: UILabel!
    
    var rate1:Double = 15.0
    var rate2:Double = 18.0
    var rate3:Double = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tipControl.removeAllSegments()
        tipControl.insertSegment(withTitle: String(rate1)+"%", at: 0, animated: false)
        tipControl.insertSegment(withTitle: String(rate2)+"%", at: 1, animated: false)
        tipControl.insertSegment(withTitle: String(rate3)+"%", at: 2, animated: false)
        billAmountTextField.becomeFirstResponder()
        billAmountTextField.keyboardType = .asciiCapableNumberPad
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard
        let newMap = defaults.dictionary(forKey: "currTime")
        if(newMap?["oldTime"] == nil){
            return
        }
        let currTime = Date()
        let oldTime = newMap?["oldTime"] as! Date
        let newDateMinutes = currTime.timeIntervalSinceReferenceDate/60
        let oldDateMinutes = oldTime.timeIntervalSinceReferenceDate/60
        let difference = CGFloat(newDateMinutes - oldDateMinutes)
        if(difference < 10){
            let oldBill = newMap?["billAmount"]
            billAmountTextField.text = oldBill as? String
        }
        else{
            billAmountTextField.text = ""
        }
        
    }
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    
    @IBAction func increaseParty(_ sender: Any) {
        var partySize = UInt8(partySizeTextField.text!) ?? 1
        partySize += 1
        partySizeTextField.text = String(partySize)
        let total = calculateTotal()
        //perPersonLabel.text = String(format: "$%.2f", total/Double(partySize))
        perPersonLabel.text = convertDoubleToCurrency(amount: total/Double(partySize))
    }
    
    @IBAction func decreaseParty(_ sender: Any) {
        var partySize = UInt8(partySizeTextField.text!) ?? 1
        partySize -= 1
        if(partySize < 1){
            partySize = 1
        }
        
        partySizeTextField.text = String(partySize)
        let total = calculateTotal()
        //perPersonLabel.text = String(format: "$%.2f", total/Double(partySize))
        perPersonLabel.text = convertDoubleToCurrency(amount: total/Double(partySize))
    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [rate1, rate2, rate3]
        if(tipControl.selectedSegmentIndex < 0){
            return
        }
        let tip = bill * (tipPercentages[tipControl.selectedSegmentIndex]*0.01)
        let total = bill + tip
        tipPercentageLabel.text = convertDoubleToCurrency(amount: tip)
        //totalLabel.text = String(format: "$%.2f", total)
        totalLabel.text = convertDoubleToCurrency(amount: total)
        let partySize = Double(partySizeTextField.text!) ?? 1
        let perPerson = convertDoubleToCurrency(amount: total/partySize)
        perPersonLabel.text = perPerson
        let defaults = UserDefaults.standard
        let newMap = [
            "billAmount": billAmountTextField.text!,
            "oldTime": Date()
        ] as [String : Any]
        defaults.set(newMap, forKey: "currTime")
    }
    
    func convertDoubleToCurrency(amount: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    
    func calculateTotal() -> Double{
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [rate1, rate2, rate3]
        if(tipControl.selectedSegmentIndex < 0){
            return 0
        }
        let tip = bill * (tipPercentages[tipControl.selectedSegmentIndex]*0.01)
        let total = bill + tip
        return total
    }
    
}

