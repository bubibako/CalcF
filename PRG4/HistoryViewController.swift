//
//  File.swift
//  PRG4
//
//  Created by Arthur Trampnau on 25/12/24.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var result: String?
    @IBOutlet weak var Calculations: UILabel!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Calculations.text = result
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func dessmissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
