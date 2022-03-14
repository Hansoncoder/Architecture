//
//  ViewController.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func gotoMVC(_ sender: Any) {
        let vc = UserViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func gotMVP(_ sender: Any) {
        let vc = UserViewController1()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func gotoMVVM(_ sender: Any) {
        let vc = UserViewController2()
        navigationController?.pushViewController(vc, animated: true)
    }
}

