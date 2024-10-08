//
//  ViewController.swift
//  PRG4
//
//  Created by Arthur Trampnau on 08/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func Button(_ sender: UIButton) {
        guard let buttonText = sender.currentTitle else { return }
        print(buttonText)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

