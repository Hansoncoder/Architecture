//
//  UserViewController1.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import UIKit

class UserViewController1: UIViewController {
    
    lazy var userView = UserView1()
    lazy var presenter = UserView1Presenter(delegate: self)
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        setupAction()
    }
    
    // 创建UI
    private func setupUI() {
        view.backgroundColor = .white
        title = "MVP"
        
        view.addSubview(userView)
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 300, width: width, height: 300)
        userView.frame = frame
    }
    
}

// MARK: - 监听事件
extension UserViewController1: Userview1Protoco {
    
    // 1.将事件转交给 presenter 处理
    private func setupAction() {
        userView.getInfo.addClick(on: self) { (self) in
            self.presenter.getUserInfo()
        }
    }
    
    // 2.实现 presenter 刷新数据的协议
    func refreshData(_ data: UserViewData) {
        userView.configInfo(data)
    }
}
