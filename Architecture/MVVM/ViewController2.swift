//
//  UserViewController2.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import UIKit

class UserViewController2: UIViewController {
    let vm = UserViewModel()
    lazy var userView = UserView2()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        bind()
    }

    // 创建UI
    private func setupUI() {
        view.backgroundColor = .white
        title = "MVVM"

        view.addSubview(userView)
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 300, width: width, height: 300)
        userView.frame = frame
    }
}

// MARK: - 绑定信号

extension UserViewController2 {
    private func bind() {
        /// 1.获取点击信号
        let input = userView.getInfo.rx.tap()

        /// 2.交给 VM 处理信号
        let output = vm.transfom(input)

        /// 3.将结果绑定到UIView上
        userView.bind(output)
    }
}
