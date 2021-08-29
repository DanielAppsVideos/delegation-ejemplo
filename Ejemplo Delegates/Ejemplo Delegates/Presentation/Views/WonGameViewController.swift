//
//  WonGameViewController.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 20/08/21.
//

import UIKit

class WonGameViewController: UIViewController {
    
    var earnedMoney: String?
    @IBOutlet weak var moneyWon: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let earned = earnedMoney {
            moneyWon.text = "$\(earned)"
        }
        
        // Do any additional setup after loading the view.
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
