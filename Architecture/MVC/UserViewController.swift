//
//  UserViewController.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import UIKit

class UserViewController: UIViewController {

    private lazy var userView = UserView()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        setupAction()
    }
    
    // 创建UI
    private func setupUI() {
        view.backgroundColor = .white
        title = "MVC"
        
        view.addSubview(userView)
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 300, width: width, height: 300)
        userView.frame = frame
    }
    
}

// MARK: - 监听事件
extension UserViewController {
    
    // 1.监听事件
    private func setupAction() {
        userView.getInfo.addClick(on: self) { (self) in
            self.getUserInfo()
        }
    }
    
    // 2.处理事件、业务逻辑、刷新UI
    private func getUserInfo() {
        let user = User(name: "张三", age: Int(arc4random()) % 30)
        
        userView.configInfo(user)
    }
}
