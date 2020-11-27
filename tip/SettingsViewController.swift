//
//  SettingsViewController.swift
//  tip
//
//  Created by Nur Nibir on 11/25/20.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        tip1Controller.text = defaults.string(forKey: "tip1")
        tip2Controller.text = defaults.string(forKey: "tip2")
        tip3Controller.text = defaults.string(forKey: "tip3")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tip1Controller: UITextField!
    @IBOutlet weak var tip2Controller: UITextField!
    @IBOutlet weak var tip3Controller: UITextField!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ViewController
        {
            let vc = segue.destination as? ViewController
            vc?.rate1 = Double(tip1Controller.text!) ?? 15.0
            vc?.rate2 = Double(tip2Controller.text!) ?? 18.0
            vc?.rate3 = Double(tip3Controller.text!) ?? 20.0
            let defaults = UserDefaults.standard
            defaults.set(tip1Controller.text!, forKey: "tip1")
            defaults.set(tip2Controller.text!, forKey: "tip2")
            defaults.set(tip3Controller.text!, forKey: "tip3")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
